# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -f "$HOME/.secrets.sh" ]; then
    . "$HOME/.secrets.sh"
fi

export GOPATH=~/go
export GO111MODULE=on
PATH=$PATH:$GOPATH/bin
PATH="/usr/lib/go-1.13/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:/usr/sbin:/sbin:$HOME/bin"
fi

export PYTHONPATH="$HOME/.local/lib/python3.5/site-packages/:$PYTHONPATH"

export XDG_CONFIG_HOME="$HOME/.config/"
export TERMINAL=urxvtcd
export EDITOR=vim
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PROJECT_HOME=$HOME/doc/projects
export WORKON_HOME=~/.virtualenvs
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VDPAU_DRIVER=va_gl
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export GDK_SCALE=1.2
export SSH_ASKPASS=""
# export LC_ALL=en_US.utf8
# export LANG=en_US.utf8
# export LANGUAGE=en
