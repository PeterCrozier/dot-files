import sys

# set default prompts
sys.ps1="\001\033[1m\033[31m\002>>> \001\033[0m\002" 
sys.ps2="\001\033[1m\033[31m\002... \001\033[0m\002" 

# tab completion for Mac OS
import readline
import rlcompleter
if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")

# useful as a calculator
from math import *
