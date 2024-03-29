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

# Determine origin and destination
if [ "$1" = "pull" ] || [ "$1" = "down" ]
then
	from="$remote"
	to="$local"
	echo -e "Pulling remote copy \e[1;31mto local\e[0m"
elif [ "$1" = "push" ] || [ "$1" = "up" ]
then
	from="$local"
	to="$remote"
	echo -e "Pushing local copy \e[1;31mto remote\e[0m"
else
	echo "USAGE"
	echo "  uiosync.sh [command]"
	echo "  command: 'push', 'pull', 'up' or 'down'"
	echo ""
	echo "A uiosync.conf file must be present at $HOME/.config and contain appropriate values for local and remote variables."
	exit 0
fi

# Running rsync
echo -e "Synchronizing direction: to \e[1;31m$to\e[0m"

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
logPath="/tmp/uiosync.log"
touch "$logPath"
read -p "Check for file conflicts? (y/N) " -t 10 check
echo ""
if [ "$check" = "y" ]
then
	echo "Checking for file conflicts. Please wait."
  eval rsync -a --verbose --dry-run --delete "$from/" "$to" > "$logPath"
	echo -e "\nFound changes in the following directories"
	cat "$logPath" | grep "/$" | grep -v "\.git/."
	read -p "Show changes in files? (y/N) " filechange
	if [ "$filechange" = "y" ]
	then
		echo -e "\nFound changes in the following files"
		cat "$logPath" | grep -v "[^(git)]/$" | grep -v "\.git/."
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
	eval rsync -az --progress --verbose --delete --delete-excluded "$from/" "$to"
	echo -e "\n\e[1;34mDone "$1"ing!\e[0m"
	exit 0
else
	echo "Aborting"
fi

