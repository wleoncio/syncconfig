#!/usr/bin/bash

usage() {
	cat << EOU
	Usage: $(basename $0) [options] FILE

	This script simplifies the file transfer between a local machine and the med-biostat servers

	Arguments:
		FILE  file to be transferred

	Options:
		-h --help
		-o  selects med-biostat as the remote (defaults to med-biostat2)
		-f  transfer from the server (defaults to "to")
EOU
}

eval "$(docopts -A ARGS -h "$(usage)" : "$@")"

# Retrieving username on remote
read -p "Username on remote: " username

# Defining defaults
servername="med-biostat2"
origin="./"

# Processing options
for a in ${!ARGS[@]} ; do
    echo "$a = ${ARGS[$a]}"
done

# Copying files
scp -J "$username"@login.uio.no $1 "$username"@"$servername".hpc.uio.no:/data/"$username"

echo Done
exit 1
