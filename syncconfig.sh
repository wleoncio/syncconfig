#! /bin/bash

# Script to manually sync files with GitHub
# Tip: edit the crontab file to make this run automatically

# ==============================================================================
# Determining computer name
# ==============================================================================
machinename=$(hostname)

# ==============================================================================
# Determining location of GitHub files
# ==============================================================================
configPath=$HOME/.config/syncconfig.conf
if [ ! -f $configPath ]
then
	echo -e "\e[31mNo config file found. Creating one on "$configPath" with default values\e[0m"
	touch $configPath
	eval echo location=$HOME/Programs/syncconfig >> $configPath
fi
source $configPath

# ==============================================================================
# Determining VSC local folder
# ==============================================================================
hasVSC() {
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
		echo "Could not determine location of VSCode directory."
		VSCdir="none"
	fi
}

# =============================================================================
# Determining i3 config folder
# =============================================================================
hasi3 () {
	if [ -d "$HOME/.i3" ]
	then
		i3dir=".i3"
	elif [ -d "$HOME/.config/i3" ]
	then
		i3dir=".config/i3"
	else
		echo "Could not determine location of i3 folder."
		i3dir="none"
	fi
}

# ==============================================================================
# Determining compositor
# ==============================================================================
hasCompositor () {
	if [ -f "$HOME/.config/picom.conf" ]
	then
		echo "Compositor found: picom"
		compositor="picom.conf"
	elif [ -f "$HOME/.config/compton.conf" ]
	then
		echo "Compositor found: compton"
		compositor="compton.conf"
	else
		echo "No supported compositor found (picom or compton)"
		compositor="other"
	fi
}

# ==============================================================================
# Determining notification daemon
# ==============================================================================
hasNotifier() {
	if [ -f "$HOME/.config/dunst/" ]
	then
		echo "Notification daemon found: dunst"
		notifier="dunstrc"
	else
		echo "No supported notification daemon found (dunst)"
		notifier="other"
	fi
}

# ==============================================================================
# Function to sync (or diff) files
# ==============================================================================
syncFiles () {
	# Defining files
	operator="$1 $4"
	origin=$2
	destination=$3
	hasCompositor
	hasNotifier
	hasi3
	hasVSC

	# Copying files
	eval "$operator" "$origin"/.bash_aliases "$destination"/config
	eval "$operator" "$origin"/.bashrc "$destination"/config
	eval "$operator" "$origin"/.gitconfig "$destination"/config
	eval "$operator" "$origin"/.radian_profile "$destination"/config
	eval "$operator" "$origin"/.vimrc "$destination"/config
	eval "$operator" "$origin"/.keynavrc "$destination"/config
	eval "$operator" "$origin"/.xbindkeysrc "$destination"/config
	eval "$operator" "$origin"/.Xresources "$destination"/config
	eval "$operator" "$origin"/.Rprofile "$destination"/config
	if [ $compositor != "other" ]
	then
		eval "$operator" "$origin"/.config/"$compositor" "$destination"/config
	fi
	eval "$operator" "$origin"/.config/gromit-mpx.cfg "$destination"/config
	if [ "$notifier" != "other" ]
	then
 		eval "$operator" "$origin"/.config/dunst/"$notifier" "$destination"/config
	fi
	if [ "$i3dir" != "none" ]
	then
		eval "$operator" -r "$origin"/"$i3dir"/* "$destination"/i3/"$machinename"/
	fi
	if [ "$VSCdir" != "none" ]
	then
		eval "$operator" "$origin"/.config/"$VSCdir"/User/keybindings.json "$destination"/VSC/
		eval "$operator" "$origin"/.config/"$VSCdir"/User/settings.json "$destination"/VSC/
		eval "$operator" -r "$origin"/.config/"$VSCdir"/User/snippets "$destination"/VSC/
	fi
}

# ==============================================================================
# Actually performing requested operation
# ==============================================================================
if [ "$1" = "push" ]
then
	echo "Copying files to local git repository"
	syncFiles cp "$HOME" "$location"
elif [ "$1" = "pull" ]
then
	echo "Copying files from local git repository"
	syncFiles cp "$HOME" "$location"
else
	echo "Comparing local files with local git repository"
	echo -e "\n# Diff report\n"
	diffFlags="--recursive --color=always"
	if [ "$1" = "diff" ]
	then
		echo -e "## Showing changes to be made when pulling\n"
		diffFlags=""$diffFlags" --suppress-common-lines -bZB -C 1"
	else
		echo -e "To get diff details, run this script with a 'diff' switch.\n"
		diffFlags=""$diffFlags" --brief"
	fi
	syncFiles diff "$HOME" "$location" "$diffFlags"
fi
