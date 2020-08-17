#!/usr/bin/env zsh


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
zle -N lfcd
cdd() {
    file=$(ls -a | fzf --reverse --prompt="dir >")

    if [ -d $file ] ; then
        cd $file
    else
        batcat $file
    fi
}
zle -N cdd
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

if [[ $DISPLAY ]]; then
    # If not running interactively, do not do anything
    [[ $- != *i* ]] && return
    [[ -z "$TMUX" ]] && exec tmux
fi

#if [ -n "$INSIDE_EMACS" ]; then
#  export TERM=dumb
#else
#  export TERM=xterm-256color
#fi
