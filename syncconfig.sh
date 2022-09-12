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
	echo echo location=$HOME/Programs/syncconfig >> $configPath
fi
source $configPath

# ==============================================================================
# Determining compositor
# ==============================================================================
hasCompositor () {
	if [ -f "$HOME/.config/picom.conf" ]
	then
		echo -e "\e[32mCompositor found: picom\e[0m"
		compositor="picom.conf"
	elif [ -f "$HOME/.config/compton.conf" ]
	then
		echo -e "\e[32mCompositor found: compton\e[0m"
		compositor="compton.conf"
	else
		echo -e "\e[31mNo supported compositor found (picom or compton)\e[0m"
		compositor="other"
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
		echo -e "\e[31mCould not determine location of i3 folder\e[0m"
		i3dir="none"
	fi
}

# ==============================================================================
# Determining notification daemon
# ==============================================================================
hasNotifier() {
	if [ -d "$HOME/.config/dunst/" ]
	then
		echo -e "\e[32mNotification daemon found: dunst\e[0m"
		notifier="dunstrc"
	else
		echo -e "\e[31mNo supported notification daemon found (dunst)\e[0m"
		notifier="other"
	fi
}

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
		echo -e "\e[31mCould not determine location of VSCode directory\e[0m"
		VSCdir="none"
	fi
	homePaths+=("$VSCdir")
}

# ==============================================================================
# Determining paths
# ==============================================================================
hasCompositor
hasi3
hasNotifier
hasVSC
homePaths=(
  "$HOME"
	""$HOME"/.config"
	""$HOME"/.config/"$compositor""
	""$HOME"/"$i3dir""
	""$HOME"/.config/dunst/"$notifier""
	""$HOME"/.config/"$VSCdir"/User"
	""$HOME"/.config/"$VSCdir"/User/snippets"
)
locationPaths=(
	""$location"/config"
	""$location"/config"
	""$location"/config"
	""$location"/i3/"$machinename"/"
	""$location"/config"
	""$location"/VSC/"
	""$location"/VSC/snippets"
)

# ==============================================================================
# Function to sync (or diff) files
# ==============================================================================
syncFiles () {
	# Defining files
	operator="$1 $4"
	origin=($2)
	destination=($3)
	# echo "Origin paths: "${origin[*]}""
	# echo "Destination paths: "${destination[*]}""

	# Copying files
	eval "$operator" "${origin[0]}"/.bash_aliases "${destination[0]}"
	eval "$operator" "${origin[0]}"/.bashrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.gitconfig "${destination[0]}"
	eval "$operator" "${origin[0]}"/.radian_profile "${destination[0]}"
	eval "$operator" "${origin[0]}"/.vimrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.keynavrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.xbindkeysrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.Xresources "${destination[0]}"
	eval "$operator" "${origin[0]}"/.Rprofile "${destination[0]}"
	eval "$operator" "${origin[1]}"/gromit-mpx.cfg "${destination[1]}"

	if [ $compositor != "other" ]
	then
		eval "$operator" "${origin[2]}" "${destination[2]}"
	fi

	if [ "$i3dir" != "none" ]
	then
		eval "$operator" -r "${origin[3]}"/* "${destination[3]}"
	fi

	if [ "$notifier" != "other" ]
	then
 		eval "$operator" "${origin[4]}" "${destination[4]}"
	fi

	if [ "$VSCdir" != "none" ]
	then
		eval "$operator" "${origin[5]}"/keybindings.json "${destination[5]}"
		eval "$operator" "${origin[5]}"/settings.json "${destination[5]}"
		eval "$operator" "${origin[6]}"/* "${destination[6]}"
	fi
}

# ==============================================================================
# Actually performing requested operation
# ==============================================================================
if [ "$1" = "push" ]
then
	echo "Copying files to local git repository"
	syncFiles cp "${homePaths[*]}" "${locationPaths[*]}"
elif [ "$1" = "pull" ]
then
	echo "Copying files from local git repository"
	syncFiles cp "${locationPaths[*]}" "${homePaths[*]}"
else
	echo "Dry-run: comparing local files with local git repository"
	diffFlags="--recursive --color=always"
	if [ "$1" = "diff" ]
	then
		echo "Showing changes to be made when pulling"
		diffFlags=""$diffFlags" --suppress-common-lines -bZB -C 1"
	else
		echo "To get diff details, run this script with 'diff' as the first argument"
		diffFlags=""$diffFlags" --brief"
	fi
	syncFiles diff "${homePaths[*]}" "${locationPaths[*]}" "$diffFlags"
fi
