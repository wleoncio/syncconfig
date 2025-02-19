#!/bin/bash

read -p "Select audio destination ([m]obile, [d]esktop): " output
COMMON_ARGS="--keyboard=aoa --power-off-on-close"

# Starting ydotoold
if [ $(ps auxf | grep ydotoold | wc -l) -eq 1 ]; then
	echo "Starting ydotoold"
	sudo -b ydotoold --socket-path="$HOME/.ydotool_socket" --socket-own="$(id -u):$(id -g)"
fi

# Simulating keypresses
# See /usr/include/linux/input-event-codes.h for more codes

# Press Super+Shift+left to move window to left monitor
YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool key 125:1 42:1 105:1 125:0 42:0 105:0

sleep 0.3

# Press (1) and release (0) Ctrl (29) + Alt (56) + H (35) to hide window
YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool key 29:1 56:1 35:1 29:0 56:0 35:0

if [ $output = 'm' ]; then
	scrcpy --no-audio $COMMON_ARGS
else
 	scrcpy $COMMON_ARGS
fi
