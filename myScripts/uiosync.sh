#!/bin/bash
# Syncs UiO accounts between local and Hjemmeområdet

source uio-colors.sh

# Config constants
configPath=$HOME/.config/uiosync.conf
if [ -f $configPath ]
then
  source $HOME/.config/uiosync.conf
else
  echo "No config file found. Please create one on "$configPath" with"
  echo "appropriate paths for "local=" and "remote=""
fi

reportLastSync() {
	# Report last sync on local
	echo -e "\n${lysblaa}Last sync on this machine:"
	echo -e "$(tail -n 1 $local/.uiosync.log)${reset}"
}
reportLastSync

# Determine origin and destination
hour=$(date +"%H")
if [ "$1" = "pull" ] || [ "$1" = "down" ]
then
	from="$remote"
	to="$local"
	toname=$(hostname)
	icon="\xE2\x86\x93"
	# Ask for confirmation if pulling in odd hours
	if [ "$hour" -gt 7 ] && [ "$hour" -lt 8 ] || [ "$hour" -gt 12 ] && [ "$hour" -lt 18 ] || [ "$hour" -gt 21 ]
	then
		echo -e "\e[1;5;31mThis is an odd time to PULL!${reset}"
		read -p "Are you sure you want to PULL? (y/N) " answer
		if [ "$answer" != "y" ]
		then
			echo "Aborting"
			exit 0
		fi
	fi
elif [ "$1" = "push" ] || [ "$1" = "up" ]
then
	from="$local"
	to="$remote"
	toname="Hjemmeområdet"
	icon="\xE2\x86\x91"
	# Ask for confirmation if pushing in odd hours
	if [ "$hour" -lt 6 ] || [ "$hour" -gt 8 ] && [ "$hour" -lt 11 ]
	then
		echo -e "\e[1;5;31mThis is an odd time to PUSH!${reset}"
		read -p "Are you sure you want to PUSH? (y/N) " answer
		if [ "$answer" != "y" ]
		then
			echo "Aborting"
			exit 0
		fi
	fi
else
	echo "USAGE"
	echo "  uiosync.sh [command]"
	echo "  command: 'push', 'pull', 'up' or 'down'"
	echo ""
	echo "A uiosync.conf file must be present at $HOME/.config and contain"
	echo "appropriate values for local and remote variables."
	exit 0
fi

# Running rsync
echo -e "Synchronizing direction: to $to (${bold}${roed}$icon${reset})"

# Checking for internet connection
connection=$(nmcli -g "STATE" general)
if [ "$connection" != "connected" ]
then
	sleep 10 # Give the computer some time to connect and try again
	connection=$(nmcli -g "STATE" general)
	if [ "$connection" != "connected" ]
	then
		echo "Not connected to the internet! Cancelling in 10 seconds"
		sleep 10
		exit 1
	fi
fi

# Dry run
templog="/tmp/uiosync_files.log"
touch "$templog"
read -p "Check for file conflicts? (y/N) " -t 3 check
echo ""
if [ "$check" = "y" ]
then
 	# Check for conflicts
	echo "Checking for file conflicts. Please wait."
  eval rsync -a --verbose --dry-run --delete "$from/" "$to" > "$templog"
	dirs=$(cat "$templog" | grep "/$" | grep -v "\.git/.")
	if [ -n "$dirs" ]; then
		echo -e "\nFound changes in the following ${oransje:-\e[38;5;214m}directories${reset}"
	  echo "$dirs"
		read -p "List changed files? (y/N) " filechange
		if [ "$filechange" = "y" ]
		then
			echo -e "\nFound changes in the following ${oransje:-\e[38;5;214m}files${reset}"
			cat "$templog" | grep -v "sending incremental file list" | grep -v "[^(git)]/$" | grep -v "\.git/."
		fi
	else
	  echo -e "${oransje:-\e[38;5;214m}No changes found${reset}"
	fi
else
	echo "Skipping conflict check"
fi

# Actual run
echo -e "\nSynchronizing to $to"
echo -e "${bold}${roed}"
printf "\e[5m%.0s$icon" $(seq 1 49)
echo -e "\n$icon THIS OPERATION WILL OVERWRITE THE CONTENTS OF $icon"
spaces_needed=$((46 - ${#to}))
spaces=$(printf "%*s" "$spaces_needed")
echo -e "$icon $to$spaces$icon"
printf "%.0s$icon" $(seq 1 49)
echo -e "${reset}\e[25m"
read -p "Are you sure you want to continue? (y/N) " answer
if [ "$answer" = "y" ]
then
	if [ "$1" = "push" ]; then
		# Registering the sync on the log file
		echo $(eval date) "push to" $toname >> $local"/.uiosync.log"
	fi
	# Actual sync
	eval rsync -az --info=name --delete --delete-excluded "$from/" "$to" | grep -v "sending incremental file list" | grep -v '/$' | grep -v '/.git/[^H]'
	if [ "$1" = "pull" ]; then
		# Registering the sync on the log file
		echo $(eval date) "pull from" $toname >> $local"/.uiosync.log"
	fi
	# Done
	echo -e "${groenn}"
	printf "%.0s$icon" $(seq 1 16)
	echo -e "\n$icon Done "$1"ing $icon"
	printf "%.0s$icon" $(seq 1 16)
	echo -e "${reset}"
	reportLastSync
	exit 0
else
	echo "Aborting"
fi
