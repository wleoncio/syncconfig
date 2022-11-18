#! /bin/bash
# Syncs UiO accounts to Hjemmeområdet

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
	echo -e "\e[1;34mPulling remote copy to local\e[0m"
elif [ "$1" = "push" ] || [ "$1" = "up" ]
then
	from="$local"
	to="$remote"
	echo -e "\e[1;34mPushing local copy to remote\e[0m"
else
	echo "USAGE"
	echo "  uiosync.sh [command]"
	echo "  command: 'push', 'pull', 'up' or 'down'"
	echo ""
	echo "A uiosync.conf file must be present at $HOME/.config and contain appropriate values for local and remote variables."
	exit 0
fi

# Running rsync
direction="from "$from" to "$to""
echo -e "Synchronizing direction: \e[1;34m"$direction"\e[0m\n"

# Checking for internet connection
connection=$(nmcli -g "STATE" general)
if [ "$connection" != "connected" ]
then
	echo "Waiting for internet connection"
	eval sleep 5
fi

## Dry run
logPath="/tmp/uiosync.log"
touch "$logPath"
read -p "Check for file conflicts? (Y/n) " check
if [ "$check" != "n" ]
then
	echo "Checking for file conflicts. Please wait."
  eval rsync -au --verbose --dry-run --delete "$from/" "$to" > "$logPath"
	echo "Found changes in the following directories"
	cat "$logPath" | grep "/$" | grep -v "\.git/."
	read -p "Show changes in files? (y/N) " filechange
	if [ $filechange = "y" ]
	then
		echo "Found changes in the following files"
		cat "$logPath" | grep -v "[^(git)]/$" | grep -v "\.git/."
	fi
else
	echo "Skipping conflict check"
fi

## Actual run
echo -e "\nSynchronizing "$direction""
echo -e "\nTHIS OPERATION WILL \e[1;31mOVERWRITE\e[0m THE CONTENTS OF \e[1;31m"$to"\e[0m"
read -p "Are you sure you want to continue? (y/N) " answer
if [ "$answer" = "y" ]
then
	eval rsync -azu --progress --verbose --delete --delete-excluded "$from/" "$to"
	echo -e "\n\e[1;34mFinished synchronizing "$direction"\e[0m"
else
	echo "Aborting"
fi

