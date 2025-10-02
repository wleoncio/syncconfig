#!/usr/bin/bash
version="0.2.0 under GPLv3 (https://choosealicense.com/licenses/gpl-3.0/)"

usage() {
    cat << EOU
Usage:
    copy2med.sh [-f] FILE
    copy2med.sh [-f] FILE -u USERNAME
    copy2med.sh -h | --help
    copy2med.sh -v | --version

Simplifies file transfer between a local machine and the med-biostat servers

Arguments:
    FILE      file to be transferred
    USERNAME  username on the remote server (will be prompted if not provided)

Options:
    -f        copy from remote to local
    -u        username on the remote server (will be prompted if not provided)
    -h        --help
    -v        --version
EOU
}

# Setting variables
help=$(usage)
servername="med-biostat2"

# Processing options
eval "$(docopts -A ARGS -h "$help" -V "$version" : "$@")"
file="${ARGS['FILE']}"

# Retrieving username on remote
if [ -z "${ARGS['USERNAME']}" ]; then
	echo -n "Username on remote: "
	read username
else
	username="${ARGS['USERNAME']}"
fi

# Origin and destination depend on direction
host="$username@login.uio.no"
server="$username@$servername.hpc.uio.no:/data/$username"
operation="$host $file $server"
if [ "${ARGS['-f']}" = true ]; then
    operation="$host $server/$file ."
fi

# Copying files
scp -J $operation

exit $?
