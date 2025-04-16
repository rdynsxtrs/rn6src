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
"""Check whether some programs will build or not."""

import pathlib
import sys

import click

from check_build import defs
from check_build import parse
from check_build import process
from check_build import util


@click.command(name="check-build")
@click.option(
    "-c",
    "--config",
    required=True,
    type=click.Path(exists=True, dir_okay=False, resolve_path=True, path_type=pathlib.Path),
)
@click.option("-v", "--verbose", is_flag=True, default=False)
@click.argument("programs", type=str, nargs=-1)
def main(config: pathlib.Path, verbose: bool, programs: tuple[str, ...]) -> None:  # noqa: FBT001
    """Parse command-line arguments, build things."""
    try:
        cfg = parse.load_config(config, programs, util.build_logger(verbose=verbose))
    except defs.CBuildError as err:
        sys.exit(f"Could not parse the configuration file: {err}")
    if not cfg.selected:
        sys.exit("No programs specified")

    for prog in cfg.selected:
        try:
            process.build_and_test(cfg, prog)
        except defs.CBuildError as err:
            sys.exit(f"Could not build the {prog} program: {err}")

    cfg.log.info("All the programs were built and tested successfully")


if __name__ == "__main__":
    main()  # pylint: disable=no-value-for-parameter
