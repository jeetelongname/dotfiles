#! /usr/bin/ env bash
#
hc() { # this aliases herbstclient to hc to make the conf more readable (don'ask me wat the $@ does)
    herbstclient "$@"
}
hc pad 0 60 

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null ; do sleep 0.5 ; done 

polybar yeet



