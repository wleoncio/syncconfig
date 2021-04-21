#!/bin/bash

if [ -z $1 ]
then
	xrandr --output DP-0 --mode 2560x1440 --rate 144.00 --primary --output HDMI-0 --rotate right --left-of DP-0 --mode 1920x1080
else
	xrandr --output HDMI-0 --rotate right --mode 1920x1080 --pos 0x0 
	xrandr --output DP-0 --primary --mode 2560x1440 --rate 144.00 --pos 1700x520 
fi

