#!/usr/bin/env zsh
#                     __
#    __  _____  ___  / /______
#   / / / / _ \/ _ \/ __/ ___/
#  / /_/ /  __/  __/ /_(__  ) 
#  \__, /\___/\___/\__/____/  
# /____/                      
#                     _____      
#   _________  ____  / __(_)___ _
#  / ___/ __ \/ __ \/ /_/ / __ `/
# / /__/ /_/ / / / / __/ / /_/ / 
# \___/\____/_/ /_/_/ /_/\__, /  
#                       /____/   
#                       for zsh :)

# Keep 1000 lines of history within the shell and save it to ~/.cache/zsh_history:
setopt histignorealldups sharehistory

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/zsh_history

# good auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -D ~/.cache/zsh/compdump
_comp_options+=(globdots)# Include hidden files.

export KEYTIMEOUT=10
bindkey -v

export ZSH="$HOME/.config/oh-my-zsh"
source $ZSH/oh-my-zsh.sh
#zsh functions that i have written/ stole live in here
source $ZDOTDIR/zsh-functions
#aliases for commands
source $ZDOTDIR/zsh-aliases
#sourcing the oh my zsh script
export ZPLUG_HOME=$ZDOTDIR/zplug
## I moved to zplug :)
## 
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2

zplug "plugins/git", as:plugin,  from:oh-my-zsh
zplug "plugins/cargo",as:plugin, from:oh-my-zsh
zplug "plugins/golang",as:plugin, from:oh-my-zsh
zplug "plugins/pip",as:plugin, from:oh-my-zsh
zplug "plugins/tmux",as:plugin, from:oh-my-zsh

zplug "plugins/alias-finder",as:plugin, from:oh-my-zsh
zplug "plugins/colored-man-pages",as:plugin, from:oh-my-zsh

zplug 'jeetelongname/Yeet-theme' , as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

