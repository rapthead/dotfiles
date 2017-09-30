# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
#if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] && [[ "`whoami`" != "root" ]]; then
  #. startx
  #logout
#fi
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH:/usr/sbin:/sbin"
fi

export PYTHONPATH="$HOME/.local/lib/python3.5/site-packages/:$PYTHONPATH"

export XDG_CONFIG_HOME="$HOME/.config/"
export MPD_HOST="cubie"
export EDITOR=vim
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=$HOME/doc/projects
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VDPAU_DRIVER=va_gl
# export LC_ALL=en_US.utf8
# export LANG=en_US.utf8
# export LANGUAGE=en
