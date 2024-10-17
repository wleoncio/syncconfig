#!/usr/bin/bash

# Allows quick switching between tasks that should belong to different branches

# Printing usage when script is called without arguments
function usage {
	echo "Usage: $(basename $0) stash_message new_branch"
	exit 1
}

if [[ ${#} -eq 0 ]]; then
	usage
fi

echo "Stashing working directory"
git stash push --all --message "$1"

echo "Checking out branch $2"
git checkout -b $2
