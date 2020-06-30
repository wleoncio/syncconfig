#! /bin/bash

# Script to manually sync files with GitHub
# Tip: edit the crontab file to make this run automatically

# ==============================================================================
# Determining if operation is push or pull
# ==============================================================================
if [ "$1" = "push" ]
then
	echo "Pushing files to GitHub"
	fromto="to"
elif [ "$1" = "pull" ]
then
	echo "Pulling files from GitHub"
	fromto="from"
else
	echo "First argument must be 'push' or 'pull'"
	exit 0
fi

# ==============================================================================
# Determining location of GitHub files
# ==============================================================================
if [ "$2" = "" ]
then
	location="$(pwd)"
else
	location="$2"
fi
echo "Copying files "$fromto" "$location""

# ==============================================================================
# Actually copying files
# ==============================================================================
if [ "$1" = "push" ]
then
	eval cp ~/.bash_aliases "$location"
	eval cp ~/.bashrc "$location"
	eval cp ~/.gitconfig "$location"
	eval cp ~/.radian_profile "$location"
	eval cp ~/.config/dunst/dunstrc "$location"
	eval cp ~/.config/i3/* "$location"
elif [ "$1" = "pull" ]
then
	eval cp "$location"/.bash_aliases ~
	eval cp "$location"/.bashrc ~
	eval cp "$location"/.gitconfig ~
	eval cp "$location"/.radian_profile ~
	eval cp "$location"/dunstrc ~/.config/dunst/dunstrc
	eval cp "$location"/i3/* ~/.config/i3
fi