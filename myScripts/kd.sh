#!/bin/bash
version="0.1.0 licensed under GPLv3"

usage() {
  cat << EOU
Usage:
  $(basename $0) SEARCH_TERM [-l LOCATION | --location LOCATION] [--ignore-case] [--starts-with] [--ends-with]
  $(basename $0) -h | --help
  $(basename $0) --version

A find wrapper to conveniently and cleanly search for files and directories.

Arguments:
  SEARCH_TERM                       term to search for (wildcards * are allowed)

Options:
  -l LOCATION, --location LOCATION  Directory to search in [default: $HOME]
  --ignore-case                     Perform case-insensitive search
  --starts-with                     Search for files that start with SEARCH_TERM
  --ends-with                       Search for files that end with SEARCH_TERM
  -h --help                         Print this help and exit
  --version                         Print version and exit

Examples:
  $(basename $0) .bashrc
  $(basename $0) bASh --ignore-case -l /usr/bin
  $(basename $0) bash --starts-with
  $(basename $0) bash --ends-with

Send bug reports and feature requests to: https://github.com/wleoncio/syncconfig/issues
EOU
}

# Setting variables
eval "$(docopts -A ARGS -h "$(usage)" -V "$version" : "$@")"

SEARCH_TERM="${ARGS['SEARCH_TERM']}"
LOCATION="${ARGS['--location']:-${ARGS['-l']:-$HOME}}"
CASE=$([ "${ARGS['--ignore-case']}" = true ] && echo iname || echo name)
PREFIX=$([ "${ARGS['--ends-with']}" = true ] && echo "*" || echo "")
SUFFIX=$([ "${ARGS['--starts-with']}" = true ] && echo "*" || echo "")

echo -e "Searching for \"$PREFIX$SEARCH_TERM$SUFFIX\" in $LOCATION\n"

find $LOCATION -$CASE $PREFIX$SEARCH_TERM$SUFFIX -print 2>/dev/null
