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

# When running MacVim from a terminal, nofork, return focus to terminal
export GUI_EDITOR='mvim -f -c "au VimLeave * !open -a Terminal"'
# enable vi edit mode on command line
set -o vi
# run MacVim in gui mode where possible
if [ "$SSH_CONNECTION" ]
then
	# SSL session - must be text mode
	export PS1="`tput setaf 4`@`hostname``tput sgr0` $PS1"
	export EDITOR=vim
	alias vi=vim
else
	export EDITOR=mvim
	alias vi="$GUI_EDITOR"
fi

alias status="git status"
alias log='git log --pretty=format:"[%h] %ae, %ar: %s" --stat'
alias gdiff="git difftool --noprompt --extcmd='$GUI_EDITOR -d'"
alias sha1="openssl sha1"

#export WINE=/Applications/Wine.app/Contents/MacOS/Wine
#alias spice="open /Users/pjc/Wine\ Files/drive_c/Program\ Files/LTC/LTspiceIV/scad3.exe"
#alias xctu="open /Users/pjc/Wine\ Files/drive_c/Program\ Files/Digi/XCTU/X-CTU.exe"

# Make ls use colors to display attributes. BSD convention, uses builtin defaults for LSCOLORS.
export CLICOLOR=true
# GNU colour convention.  Added for tree which expects this env var.  Can be used to colour by file ext.
export LS_COLORS='di=34:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=41:ex=31'

# WTF!, Java defaults to MacRoman unless you set this
export set JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8"

# 10.9 bug in Octave
alias octave='LC_CTYPE="en_US.UTF-8" /usr/local/bin/octave'

# Sage command line
alias sage="/Applications/Sage-6.3.app/Contents/Resources/sage/sage"

# coffeelint config file
export COFFEELINT_CONFIG=~/.coffeelint

# git status without unstaged files
alias gsu="git status -uno"


# look up a directory in cd cmd if not in this one
export CDPATH=".:.."

# added by Anaconda 1.9.1 installer
export PATH="/Users/pjc/anaconda/bin:$PATH"

# Enable ruby version manager, pollutes env with functions
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Ruby tags, see gem
alias rtags="ripper-tags -R"

# restore backspace key in Safari
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool YES

# MIT 6.004 simulator; assumes run from the 6004 directory
alias jsim="java -jar jsim.jar -Xms8m -Xmx32m -reporterrors"

# start ipython which crashes if not in US locale
alias ipy="~/Projects/ipython/ipython.sh"

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
alias arduino="/Applications/Arduino160.app/Contents/MacOS/JavaApplicationStub"
