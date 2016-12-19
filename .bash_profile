#
# MacOS runs .bash_profile for each new terminal window/tab (unlike Linux which runs it for login shells only).
# It runs .bashrc (and not .bash_profile) only when running bash interactively.
#
# Return the current git branch, if any
# Must be exported as it is used in PS1.
function GetGitBranch
{
	ref=$(git symbolic-ref HEAD 2>/dev/null) || return
	echo " ["${ref#refs/heads/}"]"
}
export -f GetGitBranch

# lookup word in dash doc viewer with optional language prefix
# e.g. dash ruby:print
function dash()
{
	open "dash://$*"
}
export -f dash


# console escape sequences must be included in \[ and \] to avoid moving the cursor
RED="\[$(tput setaf 1)\]"
GRN="\[$(tput setaf 2)\]"
BLU="\[$(tput setaf 4)\]"
RST="\[$(tput sgr0)\]"
export PS1="\$(date +%H:%M)$GRN\$(GetGitBranch) $RED\w$RST $ "
export SUDO_PS1="$RED\w $BLU\u$RST # "

# When running MacVim from a terminal, return focus to terminal
export GUI_EDITOR='mvim -c "au VimLeave * !open -a Terminal"'
# enable vi edit mode on command line
set -o vi
# run MacVim in gui mode where possible
if [ "$SSH_CONNECTION" ]
then
	# SSL session from another machine - must be text mode
	export PS1="$BLU@`hostname`$RST $PS1"
	export EDITOR=vim
	alias vi=vim
else
	# use GUI version
	export EDITOR=mvim
	alias vi="$GUI_EDITOR"
	alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
fi

# no longer need these and this script is sourced
unset RED BLU GRN RST

# personalise git (avoids changing ~/.gitconfig)
# only set if not already set, e.g. by ssh
echo GIT=$GIT_AUTHOR_NAME
: ${GIT_AUTHOR_NAME:="$USER"}
: ${GIT_AUTHOR_EMAIL:="$USER@$HOSTNAME"}
: ${GIT_COMMITTER_NAME:="$GIT_AUTHOR_NAME"}
: ${GIT_COMMITTER_EMAIL:="$GIT_AUTHOR_EMAIL"}
export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL

# Make ls use colors to display attributes. BSD convention, uses builtin defaults for LSCOLORS.
export CLICOLOR=true
# GNU colour convention.  Added for tree which expects this env var.  Can be used to colour by file ext.
export LS_COLORS='di=34:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=41:ex=31'

# Python interactive (not script) startup profile
export PYTHONSTARTUP=~/.pythonrc.py

# coffeelint config file
export COFFEELINT_CONFIG=~/.coffeelint

# WTF!, Java defaults to MacRoman unless you set this
export set JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8"

#############
#  aliases  #
#############

# shorten Git commands
alias gs="git status"
# git status without unstaged files
alias gsu="git status --untracked-files=no"
# commit log showing files and summary of changes, including name changes
alias glog='git log --pretty=format:"[%h] %ae, %ar: %s" --stat --follow'
# GUI diff with last commit
alias gdiff="git difftool --noprompt --extcmd='$GUI_EDITOR -f -d'"
# show location of the current repo
alias grepo="git rev-parse --show-toplevel"

# compute a SHA1 hash
alias sha1="openssl sha1"

# 10.9 bug in Octave
alias octave='LC_CTYPE="en_US.UTF-8" /usr/local/bin/octave'

# Sage command line
alias sage="/Applications/Sage-6.3.app/Contents/Resources/sage/sage"

# Ruby tags, see gem
alias rtags="ripper-tags -R"

# restore backspace key in Safari
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES

# reset LaunchServices database to remove references to deleted apps
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
alias lsreregister="lsregister -kill -r -f -all system,local,user"

# force finder to show hidden files, needs a restart so pointless here
# defaults write com.apple.finder AppleShowAllFiles TRUE

# MIT 6.004 simulator; assumes run from the 6004 directory
alias jsim="java -jar jsim.jar -Xms8m -Xmx32m -reporterrors"

# access swift compiler, assume CL tools set to XCode 6 by xcode-select
alias swift="xcrun swift"

# tail the syslog
alias con="tail -f -30 /var/log/system.log"

# Quicklook previews
alias ql="qlmanage -p"

# Remove warnings about downloaded files
alias unguard="xattr -d com.apple.quarantine"

# simple HTTP server for a directory
alias httpserver="python -m SimpleHTTPServer 8000"

# run Arduino IDE from command line
alias arduino="/Applications/Arduino.app/Contents/MacOS/Arduino"

# equivalent of Linux command
alias lsusb="system_profiler SPUSBDataType"

# manage/list xcode simulators
alias simctl="xcrun simctl"

# Xcode UUID of current Xcode.app
alias xcodeuuid="/usr/libexec/PlistBuddy -c 'Print DVTPlugInCompatibilityUUID' \"$(xcode-select -p)/../Info.plist\""

# Free huge Xcode temp files, rebuild as projects are re-opened
alias CleanDerivedData="rm -rf ~/Library/Developer/Xcode/DerivedData"

# convert plist bin<->xml
alias pl2xml="plutil -convert xml1"
alias pl2bin="plutil -convert binary1"

#########################
#  Set CDPATH and PATH  # 
#########################

# look up a directory in cd cmd if not in this one
export CDPATH=".:..:~/Projects"

# added by Miniconda2 4.1.11 installer
# as installed: defaults to 2.7, use source [de]activate python3 to get 3.5
#export PATH="$HOME/miniconda2/bin:$PATH"
#alias py3="source activate python3"
# Updated to use python3 by default, use source activate root to get python 2.7
export PATH="$HOME/miniconda2/envs/python3/bin:$PATH"

# Enable ruby version manager, pollutes env with functions, must be last thing to change $PATH
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
