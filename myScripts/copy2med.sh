#!/usr/bin/bash

# This script simplifies the file transfer between a local machine and the med-biostat servers
#

# Printing usage when script is called without arguments

function usage {
	echo "Usage: $(basename $0) [options] filename" 2>&1
	echo "	-o	selects med-biostat as the remote (defaults to med-biostat2)"
	echo "	-f	transfer from the server (defaults to \"to\")"
	exit 1
}

if [[ ${#} -eq 0 ]]; then
	usage
fi

# Retrieving username on remote
read -p "Username on remote: " username

# Defining defaults
servername="med-biostat2"
origin="./"

# Defining list of accepted arguments
optstring=":of"

# Parsing options
while getopts ${optstring} arg; do
	case "${arg}" in
		o) servername="med-biostat" ;;
		f) echo "-f not yet implemented" ;;
		?)
			echo "Invalid option: -${OPTARG}"
			echo
			usage
			;;
	esac
done

# Copying files
scp -J "$username"@login.uio.no $1 "$username"@"$servername".hpc.uio.no:/data/"$username"

echo Done
exit 1
