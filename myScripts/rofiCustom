#!/bin/bash

font="Droid Sans Regular 10"
icon="Arc-X-D"

if [ $1 = "app" ]
then
	rofi -modi run -show drun -line-padding 4 \
		-columns 2 -padding 50 -hide-scrollbar \
		-show-icons -drun-icon-theme "$icon" -font "$font"
elif [ $1 = "window" ]
then
	rofi -show window -line-padding 4 \
		-lines 6 -padding 50 -hide-scrollbar \
		-show-icons -drun-icon-theme "$icon" -font "$font"
elif [ $1 = "file" ]
then
	xdg-open "$(locate -e -i --regex "$HOME/[^\.]+" | grep -v -e "/\." | rofi -dmenu -i -p "File or folder" -threads 4 -show-icons -modi drun)"
fi
