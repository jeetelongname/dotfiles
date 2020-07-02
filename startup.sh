#!/bin/bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run "emacs --daemon"
run "setxkbmap -option caps:swapescape"
run "xrdb ~/.config/Xresources"
