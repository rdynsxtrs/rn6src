#!/usr/bin/python

import os
import sys
import shutil
import tempfile

import ply.lex
import ply.yacc

tokens = ['token']

t_token = 'x'


def t_error(t):
    pass


def p_dummy(p):
    'dummy : token'
    pass


def p_error(p):
    pass


def read_tabversion(filename):
    file = open(filename)
    data = {}
    try:
        exec file in data
    finally:
        file.close()
    return data['_tabversion']


tmpdir = tempfile.mkdtemp()
try:
    package = sys.argv[1]
except IndexError:
    raise RuntimeError, "ERROR: Required the package name as argument"

try:
    ply.lex.lex(outputdir=tmpdir, optimize=True)
    ply.yacc.yacc(outputdir=tmpdir, optimize=True, debug=False)
    lex_tabversion = read_tabversion(os.path.join(tmpdir, 'lextab.py'))
    yacc_tabversion = read_tabversion(os.path.join(tmpdir, 'parsetab.py'))
    print '%s-lex-%s, %s-yacc-%s' % (package, lex_tabversion, package,
                                     yacc_tabversion)
finally:
    shutil.rmtree(tmpdir)
