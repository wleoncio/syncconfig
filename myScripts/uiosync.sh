#! /bin/bash
# Syncs UiO accounts between local and Hjemmeområdet

# Config constants
configPath=$HOME/.config/uiosync.conf
if [ -f $configPath ]
then
  source $HOME/.config/uiosync.conf
else
  echo "No config file found. Please create one on "$configPath" with"
  echo "appropriate paths for "local=" and "remote=""
fi

# Report last sync on local
echo -e "\nLast sync on this machine:"
echo -e "$(tail -n 1 $local/.uiosync.log)\n"

# Determine origin and destination
hour=$(date +"%H")
if [ "$1" = "pull" ] || [ "$1" = "down" ]
then
	from="$remote"
	to="$local"
	toname=$(hostname)
	# Ask for confirmation if pulling in odd hours
	if [ "$hour" -gt 12 ] && [ "$hour" -lt 18 ] || [ "$hour" -gt 21 ]
	then
		echo -e "\e[1;5;31mThis is an odd time to PULL!\e[0m"
		read -p "Are you sure you want to PULL? (y/N) " answer
		if [ "$answer" != "y" ]
		then
			echo "Aborting"
			exit 0
		fi
	fi
	echo -e "Pulling remote copy \e[1;31mto local\e[0m"
elif [ "$1" = "push" ] || [ "$1" = "up" ]
then
	from="$local"
	to="$remote"
	toname="Hjemmeområdet"
	# Ask for confirmation if pushing in odd hours
	if [ "$hour" -lt 6 ] || [ "$hour" -gt 8 ] && [ "$hour" -lt 11 ]
	then
		echo -e "\e[1;5;31mThis is an odd time to PUSH!\e[0m"
		read -p "Are you sure you want to PUSH? (y/N) " answer
		if [ "$answer" != "y" ]
		then
			echo "Aborting"
			exit 0
		fi
	fi
	echo -e "Pushing local copy \e[1;31mto remote\e[0m"
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
echo -e "Synchronizing direction: \e[1;31mto $to\e[0m"

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
read -p "Check for file conflicts? (y/N) " -t 10 check
echo ""
if [ "$check" = "y" ]
then
	echo "Checking for file conflicts. Please wait."
  eval rsync -a --verbose --dry-run --delete "$from/" "$to" > "$templog"
	echo -e "\nFound changes in the following directories"
	cat "$templog" | grep "/$" | grep -v "\.git/."
	read -p "Show changes in files? (y/N) " filechange
	if [ "$filechange" = "y" ]
	then
		echo -e "\nFound changes in the following files"
		cat "$templog" | grep -v "[^(git)]/$" | grep -v "\.git/."
	fi
else
	echo "Skipping conflict check"
fi

# Actual run
echo -e "\nSynchronizing to $to"
echo -e "\nTHIS OPERATION WILL OVERWRITE THE CONTENTS OF $to"
read -p "Are you sure you want to continue? (y/N) " answer
if [ "$answer" = "y" ]
then
	# Registeing the sync on the log file
	echo $(eval date) "sync to" $toname >> $local"/.uiosync.log"
	# Actual sync
	eval rsync -az --progress --verbose --delete --delete-excluded "$from/" "$to"
	# Done
	echo -e "\n\e[1;34mDone "$1"ing!\e[0m"
	exit 0
else
	echo "Aborting"
fi
