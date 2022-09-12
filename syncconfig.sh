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
configPath=$HOME/.config/syncconfig.conf
if [ -f $configPath ]
then
  echo "Using config file found at "$configPath""
else
	echo -e "\e[31mNo config file found. Creating one on "$configPath" with default values\e[0m"
	touch $configPath
	eval echo location=$HOME/Programs/syncconfig >> $configPath
fi
source $configPath

# ==============================================================================
# Determining syncing direction
# ==============================================================================
if [ "$1" = "push" ] || [ "$1" = "pull" ]
then
	echo "Copying files "$fromto" "$location""
	echo "Copying i3 files "$fromto" "$location"/"$machinename""
fi

# ==============================================================================
# Determining VSC local folder
# ==============================================================================
has_vsc=true
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
	has_vsc=false

fi

# =============================================================================
# Determining i3 config folder
# =============================================================================
has_i3=true
if [ -d "$HOME/.i3" ]
then
	i3dir=".i3"
elif [ -d "$HOME/.config/i3" ]
then
	i3dir=".config/i3"
else
	echo "Could not determine location of i3 folder."
	has_i3=false
fi

# ==============================================================================
# Determining compositor
# ==============================================================================
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

# ==============================================================================
# Determining notification daemon
# ==============================================================================
if [ -f "$HOME/.config/dunst/" ]
then
	echo "Notification daemon found: dunst"
	notifier="dunstrc"
else
	echo "No supported notification daemon found (dunst)"
	notifier="other"
fi

# ==============================================================================
# Actually copying files
# ==============================================================================
syncFiles () {
	# Defining files
	origin=$1
	destination=$2
	compositor=$3
	has_i3=$4
	i3dir=$5
	has_vsc=$6
	VSCdir=$7
	notifier=$8

	# Copying files
	eval cp "$origin"/.bash_aliases "$destination"/config
	eval cp "$origin"/.bashrc "$destination"/config
	eval cp "$origin"/.gitconfig "$destination"/config
	eval cp "$origin"/.radian_profile "$destination"/config
	eval cp "$origin"/.vimrc "$destination"/config
	eval cp "$origin"/.keynavrc "$destination"/config
	eval cp "$origin"/.xbindkeysrc "$destination"/config
	eval cp "$origin"/.Xresources "$destination"/config
	eval cp "$origin"/.Rprofile "$destination"/config
	if [ $compositor != "other" ]
	then
		eval cp "$origin"/.config/"$compositor" "$destination"/config
	fi
	eval cp "$origin"/.config/gromit-mpx.cfg "$destination"/config
	if [ "$notifier" != "other" ]
	then
 		eval cp "$origin"/.config/dunst/"$notifier" "$destination"/config
	fi
	if [ "$has_i3" = true ]
	then
		eval cp -r "$origin"/"$i3dir"/* "$destination"/i3/"$machinename"/
	fi
	if [ "$has_vsc" = true ]
	then
		eval cp "$origin"/.config/"$VSCdir"/User/keybindings.json "$destination"/VSC/
		eval cp "$origin"/.config/"$VSCdir"/User/settings.json "$destination"/VSC/
		eval cp -r "$origin"/.config/"$VSCdir"/User/snippets "$destination"/VSC/
	fi
}

if [ "$1" = "push" ]
then
	syncFiles "$HOME" "$location" "$compositor" "$has_i3" "$i3dir" "$has_vsc" "$VSCdir" "$notifier"
elif [ "$1" = "pull" ]
then
	syncFiles "$HOME" "$location" "$compositor" "$has_i3" "$i3dir" "$has_vsc" "$VSCdir" "$notifier"
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
	eval diff "$diffFlags" ~/.bash_aliases "$location"/config
	eval diff "$diffFlags" ~/.bashrc "$location"/config
	eval diff "$diffFlags" ~/.gitconfig "$location"/config
	eval diff "$diffFlags" ~/.radian_profile "$location"/config
	eval diff "$diffFlags" ~/.vimrc "$location"/config
	eval diff "$diffFlags" ~/.keynavrc "$location"/config
	eval diff "$diffFlags" ~/.xbindkeysrc "$location"/config
	eval diff "$diffFlags" ~/.Xresources "$location"/config
	eval diff "$diffFlags" ~/.Rprofile "$location"/config
	if [ $compositor != "other" ]
	then
		eval diff "$diffFlags"  ~/.config/"$compositor" "$location"/config
	fi
	eval diff "$diffFlags" ~/.config/gromit-mpx.cfg "$location"/config
	if [ "$notifier" != "other" ]
	then
 		eval diff "$diffFlags" ~/.config/dunst/dunstrc "$location"/config
	fi
	if [ "$has_i3" = true ]
	then
		eval diff "$diffFlags" -r ~/"$i3dir"/ "$location"/i3/"$machinename"/
	fi
	if [ "$has_vsc" = true ]
	then
		eval diff "$diffFlags" ~/.config/"$VSCdir"/User/keybindings.json "$location"/VSC/keybindings.json
		eval diff "$diffFlags" ~/.config/"$VSCdir"/User/settings.json "$location"/VSC/settings.json
		eval diff "$diffFlags" ~/.config/"$VSCdir"/User/snippets "$location"/VSC/snippets
	fi
fi
