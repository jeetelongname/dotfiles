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
# This is a simple config where most settings are set here and functions and aliases are moved
# into seperate files. plugins are mangaed by zplug 

# Keep 1000 lines of history within the shell and save it to ~/.cache/zsh_history:

#history settings
setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/zsh_history ## my history file is located here

# good auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -D ~/.cache/zsh/compdump
_comp_options+=(globdots)# Include hidden files.

bindkey -v #this makes my terminal use the vim mode 
export KEYTIMEOUT=1 

#exports 
export LS_COLORS="$(vivid generate snazzy)"
export ENABLE_CORRECTION= "true"
#autosuggestions configuration
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
bindkey '^ ' autosuggest-accept

#zsh functions that i have written/ stole live in here
[ -f $ZDOTDIR/zsh-functions ] && source $ZDOTDIR/zsh-functions
#aliases for commands
[ -f $ZDOTDIR/zsh-aliases ] && source $ZDOTDIR/zsh-aliases
#keybinds will live here
[ -f $ZDOTDIR/zsh-aliases ] && source $ZDOTDIR/zsh-keys
# I like fzf so i use it for stuff
[ -f $ZDOTDIR/fzf.zsh ] && source $ZDOTDIR/fzf.zsh
## I moved to zplug :) it was a little persnickity but we are all good now :)
export ZPLUG_HOME=$ZDOTDIR/zplug
source $ZPLUG_HOME/init.zsh 

zplug "ohmyzsh/ohmyzsh", as:plugin, use:"lib/{clipboard.zsh,correction.zsh,git.zsh,grep.zsh,history.zsh,misc.zsh,prompt_info_functions.zsh,spectrum.zsh,theme-and-appearance.zsh}", defer:0
#zplug "zsh-users/zsh-syntax-highlighting", defer:2 # 
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "jeetelongname/Yeet-theme", as:theme, defer:1

zplug "plugins/git", from:oh-my-zsh, lazy:true
zplug "plugins/golang", from:oh-my-zsh, lazy:true
zplug "plugins/pip", from:oh-my-zsh, lazy:true
zplug "plugins/tmux", from:oh-my-zsh, lazy:true
zplug "plugins/alias-finder", from:oh-my-zsh, lazy:true
zplug "plugins/colored-man-pages", from:oh-my-zsh, lazy:true

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


