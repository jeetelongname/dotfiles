#!/bin/bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run "emacs --daemon"

setxkbmap -option caps:swapescape
xrdb ~/.config/Xresources
xset +fp ~/.local/share/fonts
xset fp rehash
