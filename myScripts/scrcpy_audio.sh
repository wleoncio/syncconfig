read -p "Select audio destination ([m]obile, [d]esktop): " output
COMMON_ARGS="--keyboard=aoa --power-off-on-close"

# Press (1) and release (0) Super (125) + H (35)
# See /usr/include/linux/input-event-codes.h for more codes
YDOTOOL_SOCKET="$HOME/.ydotool_socket" ydotool key 125:1 35:1 35:0 125:0

if [ $output = 'm' ]; then
	scrcpy --no-audio $COMMON_ARGS
else
 	scrcpy $COMMON_ARGS
fi
