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
    MONTH      month as a number, may also be a range [default: current month]
    YEAR       year as a four-digit number [default: current year]

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

if [[ -z "$MONTH" && -z "$YEAR" ]]; then
    # No arguments: use current month and year
    dcal_input=""
elif [[ -n "$MONTH" && -z "$YEAR" ]]; then
    # Only month provided
    dcal_input="$MONTH"
elif [[ -n "$MONTH" && -n "$YEAR" ]]; then
    # Both month and year provided
    dcal_input="$MONTH $YEAR"
else
    # Only year provided (rare case)
    dcal_input="$YEAR"
fi

gcal -K $dcal_input
