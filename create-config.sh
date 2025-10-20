#!/bin/bash
# Creates a syncconfig.conf file

# Check if the file exists
if [ -f "$HOME/.config/syncconfig.conf" ]; then
  # Prompt to overwrite
  read -p "syncconfig.conf already exists. Overwrite? (y/N) " overwrite
  if [ "$overwrite" != "y" ]; then
    echo "Exiting..."
    exit 1
  fi
fi

# Ask for location of sync directory
read -p "Enter the full path to the sync directory: " syncdir
echo "location=$syncdir" > "$HOME"/.config/syncconfig.conf
