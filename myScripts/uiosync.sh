#! /bin/bash
# Syncs UiO accounts to Hjemmeområdet

# Config constants
source $HOME/.config/uiosync.conf

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

# Checking for internet connection
connection=$(nmcli -g "STATE" general)
if [ "$connection" != "connected" ]
then
	echo "Waiting for internet connection"
	eval sleep 5
fi

# Running rsync
direction="from "$from" to "$to""
echo -e "Synchronizing direction: "$direction"\n"

## Dry run
touch uiosync.log
read -p "Check for file conflicts? (Y/n) " check
if [ "$check" != "n" ]
then
  eval rsync -azu --dry-run --delete "$from/" "$to" > uiosync.log
  cat uiosync.log | grep -v "\.git"
fi

## Actual run
echo -e "\nSynchronizing "$direction""
echo -e "\nTHIS OPERATION WILL \e[1;31mOVERWRITE\e[0m THE CONTENTS OF \e[1;31m"$to"\e[0m"
read -p "Are you sure you want to continue? (y/N) " answer
if [ "$answer" = "y" ]
then
	eval rsync -azu --delete --delete-excluded "$from/" "$to"
else
	echo "Aborting."
fi

# Final touches
echo -e "\n\e[1;34mFinished synchronizing "$direction"\e[0m"
echo "Done. Removing log."
rm uiosync.log
