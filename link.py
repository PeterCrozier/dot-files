#!/usr/bin/env python
""" link dotfiles in repo back to home directory """

import subprocess
import sys
import os
from os.path import dirname, realpath

def main():
    # get repo dir and switch to it
    repo_dir = dirname(realpath(__file__))
    os.chdir(repo_dir)

    # get tracked files
    files = subprocess.check_output("git ls-files -x '*/'", shell=True).decode("utf-8").split()
    # only want the actual dotfiles starting with a dot
    dotfiles = [f for f in files if f.startswith('.')]

    # hard link back to $HOME, prompt by default when the target already exists
    flags = "-i"
    if len(sys.argv) == 2 and sys.argv[1] == '-f':
        # force the link
        flags = "-f"
    for file in dotfiles:
        rc = os.system("ln {} {} ~".format(flags, file))
        if rc == 2:
            # CTRL-C
            print()
            break


if __name__ == "__main__":
    main()
