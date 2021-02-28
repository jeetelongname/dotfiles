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
# into seperate files. plugins are managed by zplug

# Keep 10000 lines of history within the shell and save it to ~/.cache/zsh_history:
#history settings

stty stop undef # Disable ctrl-s to freeze terminal.
setopt interactive_comments

bindkey -v #this makes my terminal use the vim mode
export KEYTIMEOUT=1

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

#exports
export LS_COLORS="$(vivid generate snazzy)"
export ENABLE_CORRECTION= "true"
#autosuggestions configuration
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
bindkey '^ ' autosuggest-accept

[ -d ~/.emacs.d ] && (rmdir ~/.emacs.d)
#zsh functions that i have written/ stole live in here
[ -f $ZDOTDIR/functions.zsh ] && source $ZDOTDIR/functions.zsh
#keybinds will live here
[ -f $ZDOTDIR/keys.zsh ] && source $ZDOTDIR/keys.zsh
# I like fzf so i use it for stuff
[ -f $ZDOTDIR/fzf.zsh ] && source $ZDOTDIR/fzf.zsh
#aliases for commands
[ -f ~/.config/aliases ] && source ~/.config/aliases

export PF_INFO="ascii title os host kernel uptime pkgs shell palette" ## what is shown when pfetch is called
#export PF_SEP=" ->" ## the seporator between the info title and the info data
#export PF_SOURCE="/opt/shell-color-scripts/randomcolors.sh" ## a script to source before running pfetch

export PF_COL1=4 ## colour of info names
export PF_COL2=7 ## colour of info details
export PF_COL3=5 ## color of the title (hostname and all that)
export PF_ALIGN="8"

export PATH="$HOME/.poetry/bin:$PATH"
