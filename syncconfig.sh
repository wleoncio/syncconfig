#! /bin/bash

check="\xE2\x9C\x94"
fail="\xE2\x9D\x8C"

# Script to manually sync files with GitHub
# Tip: edit the crontab file to make this run automatically

# ==============================================================================
# Determining computer name
# ==============================================================================
machinename=$(cat /etc/hostname)

# ==============================================================================
# Determining location of GitHub files
# ==============================================================================
configPath="$HOME/.config/syncconfig.conf"
if [ ! -f $configPath ]
then
	echo -e "$fail \e[31mNo config file found. Creating one on "$configPath" with default values\e[0m"
	touch $configPath
	echo location=$HOME/Programs/syncconfig >> $configPath
fi
source $configPath

# ==============================================================================
# Determining compositor
# ==============================================================================
hasCompositor () {
	if [ -f "$HOME/.config/picom.conf" ]
	then
		echo -e "$check Compositor found: picom"
		compositor="picom.conf"
	elif [ -f "$HOME/.config/compton.conf" ]
	then
		echo -e "$check Compositor found: compton"
		compositor="compton.conf"
	else
		echo -e "$fail No supported compositor found (picom or compton)"
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
		echo -e "$fail Could not determine location of i3 folder"
		i3dir="none"
	fi
}

# ==============================================================================
# Determining notification daemon
# ==============================================================================
hasNotifier() {
	if [ -d "$HOME/.config/dunst/" ]
	then
		echo -e "$check Notification daemon found: dunst"
		notifier="dunstrc"
	else
		echo -e "$fail No supported notification daemon found (dunst)"
		notifier="other"
	fi
}

# ==============================================================================
# Determining VSC local folder
# ==============================================================================
hasVSC() {
	if [ -d "$HOME/.config/Code" ]
	then
		echo -en "$check Syncing MS BFF Visual Studio Code"
		VSCdir="Code"
	elif [ -d "$HOME/.config/code-oss-dev" ]
	then
		echo -en "$check Syncing Code OSS-dev"
		VSCdir="code-oss-dev"
	elif [ -d "$HOME/.config/VSCodium" ]
	then
		echo -en "$check Syncing VSCodium"
		VSCdir="VSCodium"
	elif [ -d "$HOME/.config/VSCode" ]
	then
		echo -en "$check Syncing VSCode"
		VSCdir="VSCode"
	elif [ -d "$HOME/.config/Code - OSS" ]
	then
		echo -en "$check Syncing Code OSS"
		VSCdir="Code\ -\ OSS"
	else
		echo -e "$fail Could not determine location of VSCode directory"
		VSCdir="none"
	fi
	if [ $VSCdir != "none" ]
	then
		echo " (config on "$VSCdir")"
	fi
	homePaths+=("$VSCdir")
}

# ==============================================================================
# Determining paths
# ==============================================================================
echo -e "\e[34m# Determining paths\e[0m\n"
hasCompositor
hasi3
hasNotifier
hasVSC
homePaths=(
  "$HOME"
	""$HOME"/.config"
	""$HOME"/.config"
	""$HOME"/"$i3dir""
	""$HOME"/.config/dunst"
	""$HOME"/.ssh"
	""$HOME"/.config/""$VSCdir""/User"
)
locationPaths=(
	""$location"/config"
	""$location"/config"
	""$location"/config"
	""$location"/i3/"$machinename""
	""$location"/config"
	""$location"/config"
	""$location"/VSC"
)

# ==============================================================================
# Function to sync (or diff) files
# ==============================================================================
syncFiles () {
	# Defining files
	operator="$1 $4"
	origin=($2)
	destination=($3)

	# Workaround for spaces in VSC path
	if [ "${#origin[@]}" -gt 7 ]
	then
		origin[6]=""${origin[6]}" "${origin[7]}" "${origin[8]}""
		unset origin[7]
		unset origin[8]
	fi
	if [ "${#destination[@]}" -gt 7 ]
	then
		destination[6]=""${destination[6]}" "${destination[7]}" "${destination[8]}""
		unset destination[7]
		unset destination[8]
	fi

	# Copying files
	eval "$operator" "${origin[0]}"/.bash_aliases "${destination[0]}"
	eval "$operator" "${origin[0]}"/.bashrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.gitconfig "${destination[0]}"
	eval "$operator" "${origin[0]}"/.radian_profile "${destination[0]}"
	eval "$operator" "${origin[0]}"/.vimrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.keynavrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.xbindkeysrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.xinitrc "${destination[0]}"
	eval "$operator" "${origin[0]}"/.Xresources "${destination[0]}"
	eval "$operator" "${origin[0]}"/.Rprofile "${destination[0]}"
	eval "$operator" "${origin[1]}"/gromit-mpx.cfg "${destination[1]}"
	eval "$operator" "${origin[1]}"/starship.toml "${destination[1]}"
	eval "$operator" "${origin[1]}"/gh/config.yml "${destination[1]}"/gh/config.yml
	eval "$operator" "${origin[5]}"/config "${destination[5]}"

	if [ $compositor != "other" ]
	then
		eval "$operator" "${origin[2]}"/"$compositor" "${destination[2]}"
	fi

	if [ "$i3dir" != "none" ]
	then
		eval "$operator" -r "${origin[3]}"/* "${destination[3]}"
	fi

	if [ "$notifier" != "other" ]
	then
 		eval "$operator" "${origin[4]}"/"$notifier" "${destination[4]}"
	fi

	if [ "$VSCdir" != "none" ]
	then
		eval "$operator" "${origin[6]}"/keybindings.json "${destination[6]}"
		eval "$operator" "${origin[6]}"/settings.json "${destination[6]}"
		eval "$operator" "${origin[6]}"/tasks.json "${destination[6]}"
		if [[ $1 == "cp" ]]
		then
			eval "$operator" -r "${origin[6]}"/snippets "${destination[6]}"
		else
			eval "$operator" -r "${origin[6]}"/snippets "${destination[6]}"/snippets
		fi
	fi
}

# ==============================================================================
# Actually performing requested operation
# ==============================================================================
if [ "$1" = "push" ]
then
	echo -e "\n\e[34m# Copying files to local git repository\e[0m\n"
	syncFiles cp "${homePaths[*]}" "${locationPaths[*]}"
	cd $location
	echo -e "\n\e[34m# Listing modified files\e[0m\n"
	git status --short
elif [ "$1" = "pull" ]
then
	echo -e "\n\e[34m# Copying files from local git repository\e[0m\n"
	changedFiles=$(syncFiles diff "${homePaths[*]}" "${locationPaths[*]}" "--brief")
	if [ "$changedFiles" = "" ]
	then
		proceed="y"
	else
		echo -e "THIS OPERATION WILL \e[1;31mOVERWRITE\e[0m THE CONTENTS OF:\e[0m"
		echo "$changedFiles" | awk '{print $2'\r'}'
		read -p "Are you sure you want to continue? (y/N) " proceed
	fi
	if [ "$proceed" = "y" ]
	then
		syncFiles cp "${locationPaths[*]}" "${homePaths[*]}"
	else
		echo "Cancelling. Run syncconfig.sh diff to see the change details"
	fi
else
	echo -e "\n\e[34m# Dry-run: comparing local files with local git repository\e[0m\n"
	diffFlags="--recursive --color=always"
	if [ "$1" = "diff" ]
	then
		echo -e "Showing changes to be made to local files\n"
		diffFlags=""$diffFlags" --suppress-common-lines -bZB -C 1"
	else
		echo -e "To get diff details, run this script with 'diff' as the first argument\n"
		diffFlags=""$diffFlags" --brief"
	fi
	syncFiles diff "${homePaths[*]}" "${locationPaths[*]}" "$diffFlags"
fi
