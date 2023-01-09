#! /bin/bash
xrandr --output DP-1 --primary --output HDMI-3 --left-of DP-1
sleep 5
xrandr --output HDMI-3 --mode 1920x1200
sleep 2
xrandr --output HDMI-3 --rotate left
sleep 2
nitrogen --restore

