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

export ZSH="$HOME/.config/oh-my-zsh"

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

# Use lf to switch directories and bind it to ctrl-f (its not working at the mo)
lfcd() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
## bindkey comands
bindkey -v
# export KEYTIMEOUT=10

bindkey -s '^f' 'lfcd'

source $ZDOTDIR/zsh-aliases


ZSH_THEME=muse
#Set up the prompt

plugins=( ## these are oh-my-zsh plugins (i will probably move to a plugin manager)
    git
    colored-man-pages
    colorize
    golang
    themes
)
# pfetch is configured through enviroment varables.
# so for a cleaner config i move that to a diffrent file with a bit of error checking aswell
source $HOME/.config/pfetch/pfetchconfig.sh && pfetch || (echo pfetch config not found && pfetch)
#sourcing the oh my zsh script
source $ZSH/oh-my-zsh.sh
##for syntax highlighting. 
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
##for autocomplete in zsh. 
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
