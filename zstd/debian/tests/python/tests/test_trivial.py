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
"""Test the functionality with a trivial configuration."""

from __future__ import annotations

import pathlib

from unittest import mock

from typing import TYPE_CHECKING

from check_build import defs
from check_build import parse
from check_build import process
from check_build import util

if TYPE_CHECKING:
    from typing import Final


TOPDIR = pathlib.Path(__file__).parent.parent.parent

PROG_TRIVIAL = "trivial"
PROG_NO_SUCH = "no such program"


def test_trivial() -> None:
    """Parse the configuration, find the 'trivial' test, run it."""
    commands: list[tuple[list[str | pathlib.Path], pathlib.Path]] = []

    def mock_run(
        cmd: list[str | pathlib.Path],
        *,
        check: bool = False,
        cwd: pathlib.Path | None = None,
        shell: bool = False,
    ) -> None:
        """Mock subprocess.run(), check for the right programs in the right order."""
        assert check
        assert not shell

        assert cwd is not None
        assert cwd.is_dir()
        assert cwd != TOPDIR / "c/trivial"

        nonlocal commands
        if not commands:
            assert cmd == ["make"]
        elif len(commands) == 1:
            assert cwd == commands[0][1]
            assert cmd == ["make", "test"]
        else:
            raise ValueError(f"Too many commands: {commands=!r} {cmd=!r} {cwd=!r}")

        commands.append((cmd, cwd))

    cfg: Final = parse.load_config(
        TOPDIR / "c/programs.toml", (PROG_TRIVIAL,), util.build_logger(verbose=True)
    )
    assert PROG_TRIVIAL in cfg.program
    assert PROG_NO_SUCH not in cfg.program
    assert all(isinstance(prog, defs.Program) for prog in cfg.program.values())
    assert cfg.selected == [PROG_TRIVIAL]

    with mock.patch("subprocess.run", new=mock_run):
        process.build_and_test(cfg, PROG_TRIVIAL)
