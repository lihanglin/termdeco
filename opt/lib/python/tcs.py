#!/usr/bin/env python

#Tool-Chain Switch utility

CC = [\
"/bin/gcc/arm64-android-gcc/bin",
"/bin/gcc/gcc-linaro-5.4.1-2017.05-x86_64_aarch64-linux-gnu/bin",
"/bin/gcc/arm-android-gcc/bin",
]

ALIAS = [\
'arm="ARCH=arm CROSS_COMPILE=arm-linux-androideabi-"',
'arm64="ARCH=arm64 CROSS_COMPILE=aarch64-linux-android-"',
]

import argparse
import os

def get_parser():
    parser = argparse.ArgumentParser(description = "Tool-Chain Switch utility. Please do NOT use tcs.py directly. Use tcs wrapper.",
                                     epilog = "Author: FrankLin <flin@marvell.com>")

    parser.add_argument("--lsp", action = "store_true", help = "list PATH env variable")
    parser.add_argument("--lscc", action = "store_true", help = "list CC we have now")
    parser.add_argument("--usecc", nargs = "?", const = 100, type = int, metavar = "CCNUM",
                        help = "Use which CC we have. If no args specified, use HOSTCC.")
    parser.add_argument("--lsvar", action = "store_true", help = "list available make VARIABLEs.")
    parser.add_argument("--bashid", help = "the bash process id which invoked this script")
    parser.add_argument("--init", action = "store_true", help = "first and must call when login")

    ##args = parser.parse_args()
    ##print "debug::::the args we received"
    ##print args
    ##return args
    return parser

class parse_cc(object):
    def __init__(self, parser):
        self.ccs_sh = None
        self.parser = parser
        #parse_args() must be called after others
        #or it may exit when user just typed tcs.py --help
        self.args = parser.parse_args()


    def __del__(self):
        if self.ccs_sh != None:
            self.ccs_sh.close()

    def _open(self):
        _file = "/run/shm/.ccs.sh.%s" % self.args.bashid
        self.ccs_sh = open(os.path.expanduser(_file), "w")
        return self.ccs_sh

    def parse(self):
        if self.args.lsp:
            self._lsp()
        elif self.args.lscc:
            self._lscc()
        elif self.args.usecc != None:
            self._usecc()
        elif self.args.lsvar:
            self._lsvar()
        elif self.args.init:
            self._init()
        else:
            self.parser.print_help()

    def _lsp(self):
        print((os.environ["PATH"]))

    def _lscc(self):
        for idx, cc in enumerate(CC):
            if os.path.isdir(cc):
                status = ""
            else:
                status = "(No such file or directory)"
            print(("%2d  %s  %s" % (idx, cc, status)))

    def _usecc(self):
        ccnum = self.args.usecc
        orig_path = os.environ["ORIG_PATH"]

        if ccnum >= 0 and ccnum <= len(CC)-1:
            orig_path = CC[ccnum] + ":" + orig_path
        elif ccnum == 100:
            pass
        else:
            os.sys("The CC[%d] does not exist" % ccnum)

        ccs = self._open()
        new_path = "export PATH=%s\n" % orig_path
        ccs.write(new_path)
        print(new_path)

    def _init(self):
        orig_path = os.environ["PATH"]
        ccs = self._open()
        ccs.write("export ORIG_PATH=%s\n" % orig_path)
        for var in ALIAS:
            ccs.write("alias %s\n" % var)

    def _lsvar(self):
        for var in ALIAS:
            print(var)

def main():
    parser = get_parser()
    parse_cc(parser).parse()

if __name__ == "__main__":
    main()
