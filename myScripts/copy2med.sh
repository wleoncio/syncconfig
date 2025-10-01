#!/usr/bin/bash

usage() {
	cat << EOU
Usage:
	copy2med.sh FILE
	copy2med.sh FILE -u USERNAME
	copy2med.sh -h | --help
	copy2med.sh -v | --version

Simplifies file transfer between a local machine and the med-biostat servers

Arguments:
	FILE  	 file to be transferred
	USERNAME username on the remote server (will be prompted if not provided)

Options:
	-u  username on the remote server (will be prompted if not provided)
	-h --help
	-v --version
EOU
}

help=$(usage)
version="0.1.0 under GPLv3 (https://choosealicense.com/licenses/gpl-3.0/)"

# Processing options
eval "$(docopts -A ARGS -h "$help" -V "$version" : "$@")"

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
destination="$username@$servername".hpc.uio.no:/data/"$username"
scp -J "$username"@login.uio.no "${ARGS['FILE']}" "$destination"

exit $?
