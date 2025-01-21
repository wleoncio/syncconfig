read -p "Select audio destination ([m]obile, [d]esktop): " output
COMMON_ARGS="--always-on-top --keyboard=uhid"
if [ $output = 'm' ]; then
	scrcpy --no-audio $COMMON_ARGS
else
 	scrcpy $COMMON_ARGS
fi

