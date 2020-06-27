#!/bin/sh

setxkbmap -option caps:swapescape & disown
emacs --daemon & disown
