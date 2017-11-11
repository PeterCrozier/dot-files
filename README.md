Configuration files
===================


Installation
------------

* clone as `~/dotfiles`

		git clone https://github.com/PeterCrozier/dot-files.git ~/dotfiles

* run the `link.py` script in that directory to link them back to `$HOME`.  Add -f flag to force overwrite any existing files.  Note that these are hard links.

* the `marked` subdirectory contains CSS and preprocessor files for `Marked.app`

git config
----------

* Author name comes from the full login name via `id -F` and the email comes from a `~/.emailaddress` file containing the address (without a newline and `chmod 600`).

* the `.bash_profile` sets `GIT_*` environment variables rather than updating `.gitconfig`.

* these can be passed over `ssh` by extending `SendEnv` in `~/.ssh/config` to add `GIT_*`.  The target machine must have a parallel `AcceptEnv GIT_*` in their `/etc/ssh/sshd_config`
