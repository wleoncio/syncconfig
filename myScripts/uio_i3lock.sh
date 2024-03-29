#!/bin/bash
# Randomly selects a wallpaper to display on i3lock, with the appropriate color for other monitors

# Picking one image
imagePath="$HOME/UiO/Docs/Wallpapers"
imageList=($(ls "$imagePath" | cat))
chosenImage=${imageList[ $RANDOM % ${#imageList[@]} ]}
chosenImagePath=""$imagePath"/"$chosenImage""

# Determining average color of chosen image
avgColorFile="/tmp/avgColor.txt"
convert "$chosenImagePath" -resize 1x1 "$avgColorFile"
avgColor=$(cat "$avgColorFile" | grep -Po "#[[:xdigit:]]{6}")

# Suppressing notifications
pkill -xu $EUID -USR1 dunst

# Locking screen
i3lock --nofork --image="$chosenImagePath" --color="$avgColor" --pointer=default -F

# Resuming notifications
pkill -xu $EUID -USR2 dunst
