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
"""Build and test a single program."""

from __future__ import annotations

import pathlib
import shlex
import shutil
import subprocess
import tempfile

from typing import Final

from check_build import defs


class ProcessError(defs.CBuildError):
    """An error that occurred during the build and test process."""


def _run_commands(
    cfg: defs.Config, tag: str, commands: list[list[str]], *, cwd: pathlib.Path
) -> None:
    """Run a series of commands."""
    for cmd in commands:
        cmdstr = shlex.join(cmd)
        cfg.log.debug("- running `%(cmdstr)s`", {"cmdstr": cmdstr})
        try:
            subprocess.run(cmd, check=True, cwd=cwd, shell=False)
        except (OSError, subprocess.CalledProcessError) as err:
            raise ProcessError(
                f"A {tag} command failed: could not run `{cmdstr}` in {cwd}: {err}"
            ) from err


def build_and_test(cfg: defs.Config, prog: str) -> None:
    """Build and test a single program in a temporary directory."""
    progdef: Final = cfg.program.get(prog)
    if progdef is None:
        raise ProcessError(f"No {prog!r} program defined in the configuration")

    origdir: Final = cfg.topdir / prog
    if not origdir.is_dir():
        raise ProcessError(f"Not a source directory: {origdir}")

    with tempfile.TemporaryDirectory(prefix="check-build.") as tempd_obj:
        tempd: Final = pathlib.Path(tempd_obj)
        srcdir: Final = tempd / prog
        cfg.log.debug("Using %(tempd)s to build %(prog)s", {"tempd": tempd, "prog": prog})

        # Copy the source files
        cfg.log.debug("Copying %(origdir)s to %(srcdir)s", {"origdir": origdir, "srcdir": srcdir})
        try:
            shutil.copytree(origdir, srcdir, symlinks=True)
        except OSError as err:
            raise ProcessError(
                f"Could not copy {origdir} to the temporary {srcdir}: {err}"
            ) from err

        cfg.log.info("Building %(prog)s in %(srcdir)s", {"prog": prog, "srcdir": srcdir})
        _run_commands(cfg, "build", progdef.commands.build, cwd=srcdir)

        cfg.log.info("Testing %(prog)s in %(srcdir)s", {"prog": prog, "srcdir": srcdir})
        _run_commands(cfg, "test", progdef.commands.test, cwd=srcdir)

        cfg.log.info(
            "Successfully built and run %(prog)s in %(srcdir)s", {"prog": prog, "srcdir": srcdir}
        )
