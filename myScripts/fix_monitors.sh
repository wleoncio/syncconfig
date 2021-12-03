#!/bin/bash

PS3="Select monitor configuration: "
select config in imb home-top home-bottom quit
do
	case $config in
		imb)
			echo -e "The upright monitor at IMB tends to misbehave. Fixing..."
			xrandr --output HDMI-3 --rotate normal
			xrandr --output HDMI-3 --rotate left
			nitrogen --restore
			break
			;;
		home-top)
			echo -e "Setting top-aligned monitors, native resolutions."
			xrandr --output DP-0 --mode 2560x1440 --rate 144.00 --primary
			break
			;;
		home-bottom)
			echo -e "Setting Bottom-aligned monitors, highest resolutions."
			xrandr --output HDMI-0 --rotate right --mode 1920x1080 --pos 0x0
			xrandr --output DP-0 --primary --mode 2560x1440 --rate 144.00 --pos 1700x520
			break
			;;
		quit)
			echo -e "Ok, goodbye"
			break
			;;
		*)
			echo "\"$REPLY\" is not a valid option"
			;;
	esac
done
