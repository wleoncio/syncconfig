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
elif [ "$1" = "diff" ]
then
	echo "Pulling files from local git repository"
	fromto="from"
else
	echo "Comparing local files with local git repository"
	fromto="from"
fi

# ==============================================================================
# Determining location of GitHub files
# ==============================================================================
if [ "$2" = "" ]
then
	echo "Assuming git repository located at "$HOME/Programs". You can pass a different path as the second argument."
	location="$HOME/Programs/config"
else
	location="$2"
fi
if [ "$1" = "push" ] || [ "$1" = "pull" ]
then
	echo "Copying files "$fromto" "$location""
	echo "Copying i3 files "$fromto" "$location"/"$machinename""
fi

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
	eval cp ~/.config/gromit-mpx.cfg "$location"
 	eval cp ~/.config/dunst/dunstrc "$location"
	eval cp -r ~/"$i3dir"/ "$location"/i3/"$machinename"/
	eval cp ~/.config/"$VSCdir"/User/keybindings.json "$location"/VSC
	eval cp ~/.config/"$VSCdir"/User/settings.json "$location"/VSC
	eval cp ~/.config/"$VSCdir"/User/snippets/ "$location"/VSC/snippets/
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
	eval cp "$location"/gromit-mpx.cfg ~/.config
	eval cp "$location"/dunstrc ~/.config/dunst/
	eval cp "$location"/i3/"$machinename"/* ~/"$i3dir"
	eval cp "$location"/VSC/keybindings.json ~/.config/"$VSCdir"/User
	eval cp "$location"/VSC/settings.json ~/.config/"$VSCdir"/User
	eval cp "$location"/VSC/snippets/r.json ~/.config/"$VSCdir"/User/snippets/
	eval cp "$location"/VSC/snippets/rmd.json ~/.config/"$VSCdir"/User/snippets/
else
	echo -e "\n# Diff report\n"
	diffFlags="--recursive --color=always"
	if [ "$1" = "diff" ]
	then
		echo -e "## Showing changes to be made when pulling\n"
		diffFlags=""$diffFlags" --suppress-common-lines -bZB -C 1"
	else
		echo -e "To get diff details, run this script with a 'diff' switch.\n"
		diffFlags=""$diffFlags" --brief --recursive"
	fi
	eval diff "$diffFlags" ~/.bash_aliases "$location"
	eval diff "$diffFlags" ~/.bashrc "$location"
	eval diff "$diffFlags" ~/.gitconfig "$location"
	eval diff "$diffFlags" ~/.radian_profile "$location"
	eval diff "$diffFlags" ~/.vimrc "$location"
	eval diff "$diffFlags" ~/.xbindkeysrc "$location"
	eval diff "$diffFlags" ~/.Xresources "$location"
	eval diff "$diffFlags" ~/.Rprofile "$location"
	eval diff "$diffFlags" ~/.config/compton.conf "$location"
	eval diff "$diffFlags" ~/.config/picom.conf "$location"
	eval diff "$diffFlags" ~/.config/gromit-mpx.cfg "$location"
 	eval diff "$diffFlags" ~/.config/dunst/dunstrc "$location"
	eval diff "$diffFlags" -r ~/"$i3dir"/ "$location"/i3/"$machinename"/
	eval diff "$diffFlags" ~/.config/"$VSCdir"/User/keybindings.json "$location"/VSC/keybindings.json
	eval diff "$diffFlags" ~/.config/"$VSCdir"/User/settings.json "$location"/VSC/settings.json
	eval diff "$diffFlags" ~/.config/"$VSCdir"/User/snippets/ "$location"/VSC/snippets/
fi
