# Copyright (c) Peter Pentchev <roam@ringlet.net>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
"""Parse the configuration file."""

from __future__ import annotations

import dataclasses
import functools
import sys

from typing import TYPE_CHECKING, Any

import typedload.dataloader

from check_build import defs

if sys.version_info >= (3, 11):
    import tomllib
else:
    import tomli as tomllib

if TYPE_CHECKING:
    from typing import Final

    import logging
    import pathlib


class ParseError(defs.CBuildError):
    """An error that occurred while parsing the configuration file."""


@dataclasses.dataclass(frozen=True)
class TCommands:
    """The commands to build and test a program."""

    clean: list[list[str]]
    build: list[list[str]]
    test: list[list[str]]


@dataclasses.dataclass(frozen=True)
class TProgram:
    """The definition of a single program."""

    executable: str
    commands: TCommands


@dataclasses.dataclass(frozen=True)
class TConfig:
    """The top-level parsed configuration settings."""

    program: dict[str, TProgram]


def _validate_format_version(config: pathlib.Path, progs: dict[str, Any]) -> None:
    """Make sure we have the appropriate format.version table."""
    try:
        major, minor = progs["format"]["version"]["major"], progs["format"]["version"]["minor"]
    except (TypeError, KeyError) as err:
        raise ParseError(
            f"Could not determine the format version of the {config} file: {err}"
        ) from err
    if not isinstance(major, int) or not isinstance(minor, int):
        raise ParseError(
            f"The format.version.major/minor values in the {config} file must be integers"
        )
    if (major, minor) != (0, 1):
        raise ParseError(f"Unsupported format version {major}.{minor} in the {config} file")


def _select_programs(cfg: TConfig, programs: tuple[str, ...]) -> list[str]:
    """Validate the specified list of programs or return them all."""
    if not programs:
        return list(cfg.program)

    selected: Final = list(programs)
    unknown: Final = [name for name in selected if name not in cfg.program]
    if unknown:
        raise ParseError(f"Unknown programs specified: {', '.join(unknown)}")

    return selected


@functools.lru_cache(maxsize=1)
def typed_loader() -> typedload.dataloader.Loader:
    """Instantiate a typed loader that can parse type annotations."""
    return typedload.dataloader.Loader(basiccast=False, failonextra=True, pep563=True)


def load_config(
    config: pathlib.Path, programs: tuple[str, ...], logger: logging.Logger
) -> defs.Config:
    """Load the configuration file describing the list of programs to build."""
    if not config.is_absolute():
        raise ParseError(f"Not an absolute path to the config file: {config}")
    try:
        contents: Final = config.read_text(encoding="UTF-8")
    except OSError as err:
        raise ParseError(f"Could not read the {config} file: {err}") from err
    except ValueError as err:
        raise ParseError(f"Could not parse the {config} file as valid UTF-8: {err}") from err

    try:
        progs: Final = tomllib.loads(contents)
    except ValueError as err:
        raise ParseError(f"Could not parse the {config} file as valid TOML: {err}") from err
    if not isinstance(progs, dict):
        raise ParseError(f"Expected a table as the top-level object in the {config} file")

    _validate_format_version(config, progs)
    del progs["format"]
    try:
        cfg: Final = typed_loader().load(progs, TConfig)
    except ValueError as err:
        raise ParseError(f"Could not parse the {config} file: {err}") from err

    return defs.Config(
        log=logger,
        program={
            name: defs.Program(
                executable=prog.executable,
                commands=defs.Commands(
                    clean=prog.commands.clean, build=prog.commands.build, test=prog.commands.test
                ),
            )
            for name, prog in cfg.program.items()
        },
        selected=_select_programs(cfg, programs),
        topdir=config.parent,
    )
