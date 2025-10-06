#!/bin/bash
version="0.1.0 licensed under GPLv3"

usage() {
  cat << EOU
Usage:
  $(basename $0) SEARCH_TERM [-l LOCATION | --location LOCATION] [--ignore-case]
  $(basename $0) -h | --help
  $(basename $0) --version

A find wrapper to conveniently and cleanly search for files and directories.

Arguments:
  SEARCH_TERM                       term to search for (wildcards * are allowed)

Options:
  -l LOCATION, --location LOCATION  Directory to search in [default: $HOME]
  --ignore-case                     Perform case-insensitive search
  -h --help                         Print this help and exit
  --version                         Print version and exit

Examples:
  $(basename $0) .bashrc
  $(basename $0) bASh --ignore-case -l /usr/bin

Send bug reports and feature requests to: https://github.com/wleoncio/syncconfig/issues
EOU
}

# Setting variables
eval "$(docopts -A ARGS -h "$(usage)" -V "$version" : "$@")"

SEARCH_TERM="${ARGS['SEARCH_TERM']}"
LOCATION="${ARGS['--location']:-${ARGS['-l']:-$HOME}}"

if [ "${ARGS['--ignore-case']}" = true ]; then
  opts=iname
else
  opts=name
fi

echo -e "Searching for \"$SEARCH_TERM\" in $LOCATION\n"

find $LOCATION -$opts *$SEARCH_TERM* -print 2>/dev/null
find $LOCATION -$opts *$SEARCH_TERM* -print 2>/dev/null
