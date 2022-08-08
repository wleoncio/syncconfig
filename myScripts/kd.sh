#!/bin/bash

# This is a convenience wrapper for find
if [ -z $1 ];
then
  echo "Usage:"
  echo "  kd.sh SEARCH_TERM [LOCATION]"
  echo "If empty, LOCATION is $HOME"
  exit 0
else
  SEARCH_TERM=$1
fi
if [ -z $2 ];
then
  LOCATION=$HOME
else
  LOCATION=$2
fi

echo -e "Searching for \"$SEARCH_TERM\" in $LOCATION\n"

find $LOCATION -iname *$SEARCH_TERM* -print 2>/dev/null
