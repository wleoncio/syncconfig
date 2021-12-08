#! /bin/bash
# The upright monitor at IMB tends to misbehave. This fixes it

xrandr --output HDMI-3 --rotate normal
xrandr --output HDMI-3 --rotate left
nitrogen --restore
