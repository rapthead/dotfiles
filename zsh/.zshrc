# vidir !!!!
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/ohmyzsh

# function clear-scrollback-buffer {
#   # clear screen
#   clear
#   # clear buffer
#   printf '\e[3J'
#   # .reset-prompt: bypass the zsh-syntax-highlighting wrapper
#   # https://github.com/sorin-ionescu/prezto/issues/1026
#   # https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
#   # -R: redisplay the prompt to avoid old prompts being eaten up
#   # https://github.com/Powerlevel9k/powerlevel9k/pull/1176#discussion_r299303453
#   zle .reset-prompt && zle -R
# }
# 
# zle -N clear-scrollback-buffer
# bindkey '^L' clear-scrollback-buffer

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau"

# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
if type ncal > /dev/null; then
    alias cal="ncal -Mb"
else
    alias cal="cal -m"
fi

alias vim="nvim"
alias vr="gvim --remote"
alias wo="workon"
alias homeshick="source ~/.homesick/repos/homeshick/homeshick.sh; homeshick"

alias cls="tput reset"
alias cpr="rsync --progress"
alias gmc="export EDITOR='gvimremote'; mc"

alias terraform="dotenv terraform"

# ssh() { /usr/bin/ssh $* -t "env HGUSER='pgribanov <pgribanov@prural.ru>' bash -l" }

PLAYER=$(which mpv)
if [ -z $PLAYER ]; then
    PLAYER=$(which mplayer)
fi

last_playlist() {
    echo `ls -t ~/Downloads/*.m3u | head -1`
}
ml() {
    # if [ $# -eq 0 ]; then
        $PLAYER -fs -ao=alsa -playlist="$(last_playlist)" $*
    # else
    #     $PLAYER -fs
    # fi
}
mp() {
    if [ $# -eq 0 ]; then
        $PLAYER -fs --profile=pulse -playlist "$(last_playlist)"
    else
        $PLAYER -fs --profile=pulse $*
    fi
}
mr() {
    rsync -avr noname@rapthead.no-ip.org:/media/data/watch_later/ ~/.config/mpv/watch_later
    $PLAYER $*
    rsync -avr ~/.config/mpv/watch_later/ noname@rapthead.no-ip.org:/media/data/watch_later
}

alias mf=$PLAYER' --cache-secs=3 http://rapthead.no-ip.org:8004'
alias mcl=$PLAYER' --playlist=http://rapthead.no-ip.org/m3u/clips/ --shuffle -fs'
alias mcb=$PLAYER' --playlist=http://rapthead.no-ip.org/m3u/clips/brass/ --shuffle -fs'
alias feh='feh --scale-down'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(catimg git common-aliases rsync mercurial bgnotify ssh-agent)

fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source $ZSH/oh-my-zsh.sh

autoload select-word-style
select-word-style shell

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# export PREFIX=""
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
