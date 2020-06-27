#!/bin/sh

emacs --daemon & disown
setxkbmap -option caps:swapescape & disown
