#!/usr/bin/bash

usage() {
	cat << EOU
	Usage: $(basename $0) [options] FILE [(-u USERNAME)]

	Simplifies file transfer between a local machine and the med-biostat servers

	Arguments:
		FILE  file to be transferred

	Options:
		-h --help
		-o  selects med-biostat as the remote (defaults to med-biostat2)
		-f  transfer from the server (defaults to "to")
		-u  username on the remote server (will be prompted if not provided)
EOU
}

# Processing options
parsed=$(docopts -A ARGS -h "$(usage)" : "$@")
eval $parsed

# Retrieving username on remote
if [ -z "${ARGS['USERNAME']}" ]; then
	echo -n "Username on remote: "
	read username
else
	username="${ARGS['USERNAME']}"
fi

# Defining defaults
servername="med-biostat2"
origin="./"

# Copying files
scp -J "$username"@login.uio.no "${ARGS['FILE']}" "$username"@"$servername".hpc.uio.no:/data/"$username"

echo Done
exit 0
