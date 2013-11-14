#
# Return the current git branch, if any
# Must be exported as it is used in PS1.
# Make sure you have an exported SUDO_PS1 in your .bash_profile.
#
function GetGitBranch
{
	ref=$(git symbolic-ref HEAD 2>/dev/null) || return
	echo `tput setaf 2`" ["${ref#refs/heads/}"]"
}

export -f GetGitBranch
export PS1="\$(date +%H:%M)\$(GetGitBranch) `tput setaf 1`\w`tput sgr0` \$ "
#PS1="`tput setaf 1`\w `tput setaf 4`\u \$`tput sgr0` "
#PS1="\h:`tput setaf 1`\w `tput setaf 4`\u\$`tput sgr0` "
export SUDO_PS1="`tput setaf 1`\w `tput setaf 4`\u`tput sgr0` # "

# Python startup profile
export PYTHONSTARTUP=~/.pythonrc.py

# reset LaunchServces database to remove references to deleted apps
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
alias lsreregister="lsregister -kill -r -f -all system,local,user"

# force finder to show hidden files, needs a restart so pointless here
# defaults write com.apple.finder AppleShowAllFiles TRUE

alias status="git status"

alias sha1="openssl sha1"

export WINE=/Applications/Wine.app/Contents/MacOS/Wine
alias kclient="$WINE /Applications/ADP/kclient.exe"
alias spice="open /Users/pjc/Wine\ Files/drive_c/Program\ Files/LTC/LTspiceIV/scad3.exe"
alias xctu="open /Users/pjc/Wine\ Files/drive_c/Program\ Files/Digi/XCTU/X-CTU.exe"

#export GOROOT=$HOME/go
#export GOBIN=$GOROOT/bin
#export GOOS=darwin
#export GOARCH=amd64
#export PATH="$PATH:$GOBIN:/Library/goodies/OracleClient/instantclient_10_2"

# Make ls use colors to display attributes.  Use defaults.
export CLICOLOR=true

# WTF!, Java defaults to MacRoman unless you set this
export set JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8"

# 10.9 bug in Octave
alias octave='LC_CTYPE="en_US.UTF-8" /usr/local/bin/octave'

# Sage command line
alias sage="/Applications/Sage-5.12-OSX-64bit-10.8.app/Contents/Resources/sage/sage"

# coffeelint config file
export COFFEELINT_CONFIG=~/.coffeelint

# enable vi edit mode on command line
export EDITOR=vim
alias vi=mvim
set -o vi

# look up a directory in cd cmd if not in this one
export CDPATH=".:.."


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
