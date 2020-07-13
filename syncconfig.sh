#! /bin/bash

# Script to manually sync files with GitHub
# Tip: edit the crontab file to make this run automatically

# ==============================================================================
# Determining if operation is push or pull
# ==============================================================================
if [ "$1" = "push" ]
then
	echo "Pushing files to local git repository"
	fromto="to"
elif [ "$1" = "pull" ]
then
	echo "Pulling files from local git repository"
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
	location="$HOME/Dropbox/Software/config/"
else
	location="$2"
fi
echo "Copying files "$fromto" "$location""

# ==============================================================================
# Determining VSC local folder
# ==============================================================================
if [ -d "$HOME/.config/VSCodium" ]
then
	VSCdir="VSCodium"
elif [ -d "$HOME/.config/VSCode" ]
then
	VSCdir="VSCode"
else
	echo "Could not determine location of VSCode directory. Exiting."
	exit 0
fi

# ==============================================================================
# Determining computer name
# ==============================================================================
machinename=$(hostname)

# ==============================================================================
# Actually copying files
# ==============================================================================
if [ "$1" = "push" ]
then
	eval cp ~/.bash_aliases "$location"
	eval cp ~/.bashrc "$location"
	eval cp ~/.gitconfig "$location"
	eval cp ~/.radian_profile "$location"
	eval cp ~/.vimrc "$location"
	eval cp ~/.config/dunst/dunstrc "$location"
	eval cp ~/.config/i3/* "$location"/i3/"$machinename"/
	eval cp ~/.config/"$VSCdir"/User/keybindings.json "$location"/VSC
	eval cp ~/.config/"$VSCdir"/User/settings.json "$location"/VSC
	eval cp ~/.config/"$VSCdir"/User/snippets/* "$location"/VSC
elif [ "$1" = "pull" ]
then
	eval cp "$location"/.bash_aliases ~
	eval cp "$location"/.bashrc ~
	eval cp "$location"/.gitconfig ~
	eval cp "$location"/.radian_profile ~
	eval cp "$location"/.vimrc ~
	eval cp "$location"/dunstrc ~/.config/dunst/
	eval cp "$location"/i3/"$machinename"/* ~/.config/i3/
	eval cp "$location"/VSC/keybindings.json ~/.config/"$VSCdir"/User
	eval cp "$location"/VSC/settings.json ~/.config/"$VSCdir"/User
	eval cp "$location"/VSC/r.json ~/.config/"$VSCdir"/User/snippets/
	eval cp "$location"/VSC/rmd.json ~/.config/"$VSCdir"/User/snippets/
fi
