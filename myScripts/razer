#! /bin/bash
command=$1
if [ "$command" = "reset" ]; then
	polychromatic-cli -o game_mode -p 0
	polychromatic-cli -o static -c "#0000FF"
elif [ $command = 'game' ]; then
	polychromatic-cli -o game_mode -p 1
fi
