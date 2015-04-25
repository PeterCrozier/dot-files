# files to copy, not including the .git repo
list=`cat <<EOT
.bash_profile
.clang-format
.gemrc
.gitattributes
.gitconfig
.gitexcludes
.gvimrc
.irbrc
.octaverc
.pythonrc.py
.sqliterc
.vimrc
EOT`
DROPBOX=~/Dropbox/dotfiles
TIMESTAMP=${DROPBOX}/timestamp
find $list -newer $TIMESTAMP -exec cp -p {} $DROPBOX \;
date >$TIMESTAMP
