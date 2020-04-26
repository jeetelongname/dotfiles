#!/usr/bin/env bash


function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

# run "nitrogen --restore"
# run "compton --config ~/.config/compton/compton.conf"
# run "barrier"
# run "kdeconnect-indicator"
