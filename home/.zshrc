# Path to your oh-my-zsh installation.
export LC_ALL=en_US.utf8
export LANG=en_US.utf8
export LANGUAGE=en
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau"

# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vr="gvim --remote"
alias wo="workon"

alias cpr="rsync --progress"
alias gmc="export EDITOR='gvimremote'; mc"

ssh() { /usr/bin/ssh $* -t "env HGUSER='pgribanov <pgribanov@prural.ru>' bash -l" }

PLAYER=$(which mpv)
if [ -z $PLAYER ]; then
    PLAYER=$(which mplayer)
fi
#function ml mp mh mf mcl () {
#    zparseopts -E -D -A parsed_args -profile:=profile profile:=profile -playlist:=playlist playlist:=playlist
#    MPV_ARGS=$*
#    if [[ $0 == 'mp' || $0 == 'ml' ]] then
#        if [[ -z $playlist ]] then
#            playlist="--playlist" "`ls -t ~/Downloads/*.m3u | head -1`"
#        fi
#        MPV_ARGS+=("-fs")
#    fi
#
#    if [[ $0 == 'mp' ]] then
#        if [[ -n $profile ]] then
#            #TODO
#        else
#            profile=("--profile", "pulse")
#        fi
#    fi
#
#    if [[ -n $playlist ]] then
#        MPV_ARGS+=$playlist
#    fi
#
#    if [[ -n $profile ]] then
#        MPV_ARGS+=$profile
#    fi
#
#    echo $PLAYER $MPV_ARGS
#    $PLAYER $MPV_ARGS
#}
alias ml=$PLAYER' -fs -ao alsa -playlist "`ls -t ~/Downloads/*.m3u | head -1`"'
alias mp=$PLAYER' -fs -profile pulse -playlist "`ls -t ~/Downloads/*.m3u | head -1`"'
alias mh=$PLAYER' -fs -profile hw,pulse -playlist "`ls -t ~/Downloads/*.m3u | head -1`"'
alias mf=$PLAYER' -cache 1024 http://192.168.0.40:8004'
alias mcl=$PLAYER' --playlist=http://192.168.0.40/clips/all.m3u --shuffle -fs'
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
#plugins=(git catimg)
plugins=(catimg git bower common-aliases rsync django mercurial fabric virtualenv virtualenvwrapper)

fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# function hg_get_branch_name() {
#   if [ $(in_hg) ]; then
#      hg prompt --angle-brackets "\
# < on %{$fg[magenta]%}<branch>%{$reset_color%}>\
# < at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
# %{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
# patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
#     # echo $(hg branch)
#   fi
# }
function hg_get_branch_name() {
    if [ $(in_hg) ]; then
        hg_branch="< on %{$fg[magenta]%}<branch>%{$reset_color%}>"
        hg_tags="< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>"
        hg_bookmarks="< %{$fg[green]%}<bookmark>%{$reset_color%}>"
        hg_status="%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<"
        hg_patches="patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>"

        hg prompt --angle-brackets "$hg_branch$hg_bookmarks$hg_status$hg_pathces" 2>/dev/null
    fi
}
RPROMPT=$RPROMPT'$(hg_prompt_info)'

autoload select-word-style
select-word-style shell

export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=$HOME/Docs/django/projects
export VIRTUAL_ENV_DISABLE_PROMPT=1
