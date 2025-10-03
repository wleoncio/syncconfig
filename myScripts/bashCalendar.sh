#!/bin/bash
source ic.sh
version="0.1.0 licensed under GPLv3"

usage() {
    cat << EOU
Usage:
    $(basename $0) [MONTH] [YEAR]
    $(basename $0) -h | --help
    $(basename $0) --version

Generates a calendar for a specified month and year, or the current month if
none is provided.

Arguments:
    MONTH      month as MM, may also be a range [default: current month]
    YEAR       year as YYYY, may be range if MM is given [default: current year]

Options:
    -h --help  Print this help and exit
    --version  Print version and exit
EOU
}

# Setting variables
eval "$(docopts -A ARGS -h "$(usage)" -V "$version" : "$@")"

# Get MONTH and YEAR from ARGS, default to current if not provided
MONTH="${ARGS['MONTH']}"
YEAR="${ARGS['YEAR']}"

gcal --with-week-number $MONTH $YEAR
