#!/usr/bin/python

# ToolChain Switcher utility

# todo
# add short option
# work for py3 and py2
# add option for recover the original path
# remove --bashid, --init
# separate CC and ALIAS to another .cclist file
# when typing --lscc, add * to mark what toolchain is used now
# remove hardcode useing /shm/ ... (some system did not have it)
# may use "mktemp -q --suffix=.tcs" and use rm -f xxx
#   tfile=$(mktemp /tmp/foo.XXXXXXXXX)
# change --lsvar to --lsalias or both

# tcs.py [options] [init] tempfile

import sys
import os
import os.path as osp
import logging
import argparse

logging.basicConfig(format="%(levelname)s: %(message)s", level=logging.INFO)

pr_info = logging.info
pr_debug = logging.debug
pr_warn = logging.warning

cmdopts = None

def pr_error(msg, *args, **kwargs):
    logging.error(msg, *args, **kwargs)
    sys.exit(1)

# import the user defined toolchain lists
import imp
try:
    cclists = imp.load_source('cclists',
                              osp.join(os.environ['HOME'], '.cclists'))
except FileNotFoundError:
    pr_error("~/.cclists: File not found")


def parse_cmdopts():
    global cmdopts

    parser = argparse.ArgumentParser(description="ToolChain Switcher utility",
                                     prog="tcs",
                                     epilog="Author: Li-Hang Lin <lihang.lin@gmail.com>")

    parser.add_argument("-p", "--lsp", action="store_true", help="list PATH environment variable")
    parser.add_argument("-l", "--lscc", action="store_true", help="list the available toolchain from .cclists")
    parser.add_argument("-c", "--usecc", const=-1, nargs="?", type=int, metavar="CCNUM",
                        help="Use which CC. If no args was specified, restore the PATH to its original value")
    parser.add_argument("-a", "--lsvar", action="store_true", help="list the current defined alias from .cclists")
    parser.add_argument("--lsalias", action="store_true", help="same as -a, --lsvar")
    parser.add_argument("-r", "--recover", action="store_true", help="restore the PATH to its original value")

    cmdopts = parser.parse_args()
    cmdopts.parser = parser

def tcs_init():
    orig_path = os.environ["PATH"]
    cmdopts.tcs.write("export ORIG_PATH=%s\n" % orig_path)
    for i in cclists.ALIAS:
        cmdopts.tcs.write("alias %s\n" % i)

def tcs_lscc():
    path = os.environ["PATH"]

    for i, cc in enumerate(cclists.CC):
        if cc in path:
            cc_inuse = "[%2d]*" % i
        else:
            cc_inuse = "[%2d]" % i

        if os.path.isdir(cc):
            status = ""
        else:
            status = "(No such file or directory)"

        print("%s  %s %s" % (cc_inuse, cc, status))

def tcs_usecc():
    ccnum = cmdopts.usecc
    orig_path = os.environ["ORIG_PATH"]

    if ccnum == -1:
        pass
    elif ccnum >= 0 and ccnum <= len(cclists.CC)-1:
        orig_path = cclists.CC[ccnum] + ":" + orig_path
    else:
        pr_error("CC[%d]: The toolchain was Not found" % ccnum)

    cmdopts.tcs.write("export PATH=%s\n" % orig_path)
    print("Update PATH: %s" % orig_path)

def tcs_recover():
    orig_path = os.environ["ORIG_PATH"]
    cmdopts.tcs.write("export PATH=%s\n" % orig_path)
    print("Update PATH: %s" % orig_path)

def main():
    tcs = open(sys.argv[-1], 'w')
    sys.argv.pop()

    if len(sys.argv) > 1 and sys.argv[-1] == "init":
        tcsinit = True
        sys.argv.pop()
    else:
        tcsinit = False

    parse_cmdopts()
    cmdopts.tcs = tcs
    pr_debug(cmdopts)

    if tcsinit:
        tcs_init()
    else:
        if cmdopts.lsp:
            print(os.environ["PATH"])
        elif cmdopts.lscc:
            tcs_lscc()
        elif cmdopts.usecc is not None:
            tcs_usecc()
        elif cmdopts.lsvar or cmdopts.lsalias:
            for var in cclists.ALIAS:
                print(var)
        elif cmdopts.recover:
            tcs_recover()
        else:
            cmdopts.parser.print_help()

    if cmdopts.tcs:
        cmdopts.tcs.close()

if __name__ == "__main__":
    main()
