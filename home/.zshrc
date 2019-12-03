# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

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
alias vim="nvim"
alias vr="gvim --remote"
alias wo="workon"

alias cls="tput reset"
alias cpr="rsync --progress"
alias gmc="export EDITOR='gvimremote'; mc"

# ssh() { /usr/bin/ssh $* -t "env HGUSER='pgribanov <pgribanov@prural.ru>' bash -l" }

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
plugins=(catimg git bower common-aliases rsync mercurial fabric virtualenv virtualenvwrapper ssh-agent notify chucknorris)

fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source $ZSH/oh-my-zsh.sh

# User configuration

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

# function hg_prompt_info() {
#     if [ $(in_hg) ]; then
#         hg_branch="< on %{$fg[red]%}<branch|quiet>%{$reset_color%}>"
#         hg_tags="< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>"
#         hg_bookmarks="< %{$fg[green]%}<bookmark>%{$reset_color%}>"
#         hg_status="<%{$fg[green]%}<status|modified|unknown>>"
#         hg_patches="patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>"
# 
#         hg prompt --angle-brackets "$hg_branch$hg_bookmarks$hg_status$hg_pathces" 2>/dev/null
#     fi
# }

# PROMPT='$_1LEFT
# $(virtualenv_prompt_info) > $_LIBERTY '

# PROMPT='$COLUMNS ${#${(%)_1LEFT}} > x
# $_1LEFT ${(r:$((COLUMNS-${#${(%)_1LEFT}}))::x:)}
# $(virtualenv_prompt_info) > $_LIBERTY '

bureau_precmd () {
  _1SPACES=`get_space $_1LEFT $_1RIGHT`
  print
  print -rP "${_1LEFT}%U${_1SPACES}%u${_1RIGHT}"
}

PROMPT='$(virtualenv_prompt_info) > $_LIBERTY '
RPROMPT='$(bureau_git_prompt)'

autoload select-word-style
select-word-style shell

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
