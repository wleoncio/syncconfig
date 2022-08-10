for i in `seq $1 -1 1`
do
	echo -ne "\r$i "
	sleep 1
done
echo -ne "\r0"
sleep 1
echo -e " - $1 seconds are over!"
notify-send "Time's up!"
