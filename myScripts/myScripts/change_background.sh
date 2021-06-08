#!/bin/bash

# Changing background 
if [ $1 == 0 ]
then
	nitrogen --head=0 --save --set-zoom-fill --random ~/Pictures/rid/
elif [ $1 == 1 ]
then
	nitrogen --head=1 --save --set-zoom-fill --random ~/Pictures/rid/
else
	nitrogen --head=0 --save --set-zoom-fill --random ~/Pictures/rid/
	nitrogen --head=1 --save --set-zoom-fill --random ~/Pictures/rid/
fi

# Informing name of new picture

bg_config=.config/nitrogen/bg-saved.cfg

# Collect background files
bg_0=$(cat .config/nitrogen/bg-saved.cfg | grep file | tail -2 | head -1)
bg_1=$(cat .config/nitrogen/bg-saved.cfg | grep file | tail -2 | tail -1)

# Retrieving title
title_0=$(echo $bg_0 | cut -d '/' -f 7 | cut -d '_' -f 4)
title_1=$(echo $bg_1 | cut -d '/' -f 7 | cut -d '_' -f 4)

if [ $1 == 0 ]
then
	eval notify-send --urgency low 'Setting' '"$title_0"'
elif [ $1 == 1 ]
then
	eval notify-send --urgency low 'Setting' '"$title_1"'
fi
