#!/bin/bash

if [ -z $1 ]
then
	# Top-aligned monitors, native resolutions
	xrandr --output DP-0 --mode 2560x1440 --rate 144.00 --primary
else
	# Bottom-aligned monitors, highest resolutions
	xrandr --output HDMI-0 --rotate right --mode 1920x1080 --pos 0x0
	xrandr --output DP-0 --primary --mode 2560x1440 --rate 144.00 --pos 1700x520
fi

