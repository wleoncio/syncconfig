#!/bin/bash

bg_config=.config/nitrogen/bg-saved.cfg

# Collect background files
bg_0=$(cat .config/nitrogen/bg-saved.cfg | grep file | tail -2 | head -1)
bg_1=$(cat .config/nitrogen/bg-saved.cfg | grep file | tail -2 | tail -1)

# Removing "file"
bg_0=$(echo $bg_0 | cut -d '=' -f 2)
bg_1=$(echo $bg_1 | cut -d '=' -f 2)

# Retrieving title
title_0=$(echo $bg_0 | cut -d '/' -f 7)
title_1=$(echo $bg_1 | cut -d '/' -f 7)



# Removing or printing the file

if [ $# -eq 0 ]
then
	echo No parameters passed. Printing background locations
	echo $bg_0
	echo $bg_1
elif [ $1 -eq 1 ]
then
	eval notify-send 'Removing "$title_1"' --urgency low
	eval rm \""$bg_1"\"
elif [ $1 -eq 0 ]
then
	eval notify-send 'Removing "$title_0"' --urgency low
	eval rm \""$bg_0"\"
fi

