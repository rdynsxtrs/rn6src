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
"""Common definitions for the check-build library."""

from __future__ import annotations

import dataclasses

from typing import TYPE_CHECKING

if TYPE_CHECKING:
    import logging
    import pathlib


VERSION = "0.1.0"


class CBuildError(Exception):
    """An error that occurred during the check-build routines operation."""


@dataclasses.dataclass(frozen=True)
class Commands:
    """The commands to build and test a program."""

    clean: list[list[str]]
    build: list[list[str]]
    test: list[list[str]]


@dataclasses.dataclass(frozen=True)
class Program:
    """The definition of a single program."""

    executable: str
    commands: Commands


@dataclasses.dataclass(frozen=True)
class Config:
    """Runtime configuration for the check-build routines."""

    log: logging.Logger
    program: dict[str, Program]
    selected: list[str]
    topdir: pathlib.Path
