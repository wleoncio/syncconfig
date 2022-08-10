#!/bin/bash
# Counts down from $1 seconds

time=$1

# Help
if [ -z "$time" ]
then
	echo "Usage: timer.sh [seconds]"
	exit 1
fi

# Countdown
echo "$(date +%H:%M:%S) - Counting down from $time seconds"
for i in `seq $time -1 1`
do
	echo -ne "\r$i "
	sleep 1
done

# Final feedback
echo -ne "\r$(date +%H:%M:%S) - $time seconds are over!\n"
notify-send "Time's up!"
