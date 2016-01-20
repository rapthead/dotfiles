# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau"

# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vr="gvim --remote"
alias wo="source ~/.oh-my-zsh/plugins/virtualenvwrapper/virtualenvwrapper.plugin.zsh; workon"
alias homeshick="source ~/.homesick/repos/homeshick/homeshick.sh; homeshick"

alias cpr="rsync --progress"
alias gmc="export EDITOR='gvimremote'; mc"

ssh() { /usr/bin/ssh $* -t "env HGUSER='pgribanov <pgribanov@prural.ru>' bash -l" }

PLAYER=$(which mpv)
if [ -z $PLAYER ]; then
    PLAYER=$(which mplayer)
fi
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
plugins=(catimg git bower common-aliases rsync django mercurial fabric virtualenv )

fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source $ZSH/oh-my-zsh.sh

function hg_get_branch_name() {
    if [ $(in_hg) ]; then
        hg_branch="< on %{$fg[magenta]%}<branch>%{$reset_color%}>"
        hg_tags="< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>"
        hg_bookmarks="< %{$fg[green]%}<bookmark>%{$reset_color%}>"
        hg_status="%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}"
        hg_patches="patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>"

        hg prompt --angle-brackets "$hg_branch$hg_bookmarks$hg_status$hg_pathces" 2>/dev/null
    fi
}

autoload select-word-style
select-word-style shell

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
# add-zsh-hook precmd vcs_info
precmd() {
    vcs_info
}

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg git
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' actionformats "%S" "%s/%b %u%c (%a)"
zstyle ':vcs_info:*' formats "%b/%m %u%c" "%F{yellow}%s%F{reset}"
# zstyle ':vcs_info:*' nvcsformats "%~" ""

+vi-hg-bookmarks() {
    local s i
    # The bookmarks returned by `hg' are available in
    # the functions positional parameters.
    for i in "$@"; do
        echo $i
    done
    # tiny styling tweak when bookmark exists
    # [[ -n $s ]] && s=/$s
    hook_com[hg-bookmark-string]='test'
    # ret=1
    return 0
}

zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
zstyle ':vcs_info:*+*:*' debug true

PROMPT=$PROMPT'${vcs_info_msg_0_}'
RPROMPT=$RPROMPT'${vcs_info_msg_1_}'

