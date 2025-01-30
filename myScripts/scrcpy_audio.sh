read -p "Select audio destination ([m]obile, [d]esktop): " output
COMMON_ARGS="--keyboard=aoa --power-off-on-close"

# See /usr/include/linux/input-event-codes.h for more codes
# Press Super+Shift+left to move window to left monitor
YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool key 125:1 42:1 105:1 125:0 42:0 105:0

# Press (1) and release (0) Super (125) + H (35) to hide window
YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool key 125:1 35:1 35:0 125:0

if [ $output = 'm' ]; then
	scrcpy --no-audio $COMMON_ARGS
else
 	scrcpy $COMMON_ARGS
fi
