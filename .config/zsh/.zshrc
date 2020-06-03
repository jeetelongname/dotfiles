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
_comp_options+=(globdots)		# Include hidden files.

export KEYTIMEOUT=10
bindkey -v

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

export ZSH="$HOME/.config/oh-my-zsh"

ZSH_THEME=muse
## these are oh-my-zsh plugins (i will probably move to a plugin manager)
plugins=( 
    alias-finder
    cargo
    colored-man-pages
    git
    golang
    pip
    themes
    tmux
)
# pfetch is configured through enviroment varables.
# so for a cleaner config i move that to a diffrent file with a bit of error checking aswell



# bindkey -a
#zsh functions that i have written/ stole live in here
source $ZDOTDIR/zsh-functions
#
source $ZDOTDIR/zsh-aliases
#sourcing the oh my zsh script
source $ZSH/oh-my-zsh.sh
##for syntax highlighting. 
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
##for autocomplete in zsh. 
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
