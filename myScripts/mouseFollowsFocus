#!/bin/bash
# Requires xdotool and cwininfo

i3-msg focus $1 # left, right, up, down

# from https://unix.stackexchange.com/a/14170
unset x y w h
eval $(xwininfo -id $(xdotool getactivewindow) |
    sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
           -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
           -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
           -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )
window=($(echo -n "$x $y $w $h"))

xCen=$(echo "$x+($w/2)" | bc)
yCen=$(echo "$y+($h/2)" | bc)

xdotool mousemove $xCen $yCen

