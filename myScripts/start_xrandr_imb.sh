#! /bin/bash
xrandr --output DP-2 --mode 2560x1440
sleep 2
xrandr --output DP-2 --rotate left
sleep 2
xrandr --output DP-1 --primary --output DP-2 --left-of DP-1
sleep 5
nitrogen --restore

