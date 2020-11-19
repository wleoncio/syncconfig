#! /bin/bash

# Script to manually sync files with GitHub
# Tip: edit the crontab file to make this run automatically

# ==============================================================================
# Determining computer name
# ==============================================================================
machinename=$(hostname)

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
echo "Copying i3 files "$fromto" "$location""$machinename""

# ==============================================================================
# Determining VSC local folder
# ==============================================================================
if [ -d "$HOME/.config/VSCodium" ]
then
	VSCdir="VSCodium"
elif [ -d "$HOME/.config/VSCode" ]
then
	VSCdir="VSCode"
elif [ -d "$HOME/.config/Code - OSS" ]
then
	VSCdir="Code\ -\ OSS"
else
	echo "ERROR: Could not determine location of VSCode directory. Exiting."
	exit 0
fi

# =============================================================================
# Determining i3 config folder
# =============================================================================
if [ -d "$HOME/.i3" ]
then
	i3dir=".i3"
elif [ -d "$HOME/.config/i3" ]
then
	i3dir=".config/i3"
else
	echo "ERROR: Could not determine location of i3 folder. Exiting."
	exit 0
fi

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
	eval cp ~/.xbindkeysrc "$location"
	eval cp ~/.Xresources "$location"
	eval cp ~/.Rprofile "$location"
	eval cp ~/.config/compton.conf "$location"
	eval cp ~/.config/picom.conf "$location"
 	eval cp ~/.config/dunst/dunstrc "$location"
	eval cp ~/"$i3dir"/* "$location"/i3/"$machinename"/
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
	eval cp "$location"/.xbindkeysrc ~
	eval cp "$location"/.Xresources ~
	eval cp "$location"/.Rprofile ~
	eval cp "$location"/compton.conf ~/.config
	eval cp "$location"/picom.conf ~/.config
	eval cp "$location"/dunstrc ~/.config/dunst/
	eval cp "$location"/i3/"$machinename"/* ~/"$i3dir"
	eval cp "$location"/VSC/keybindings.json ~/.config/"$VSCdir"/User
	eval cp "$location"/VSC/settings.json ~/.config/"$VSCdir"/User
	eval cp "$location"/VSC/r.json ~/.config/"$VSCdir"/User/snippets/
	eval cp "$location"/VSC/rmd.json ~/.config/"$VSCdir"/User/snippets/
fi
