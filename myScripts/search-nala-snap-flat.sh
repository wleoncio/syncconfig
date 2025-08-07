#!/usr/bin/bash
#
# Searches for a package on APT, Snap and Flatpak repositories

pkg=$1

echo "Searching apt"
echo

nala search $pkg

echo
echo "Searching snap"
echo

snap search $pkg

echo
echo "Searching flatpak"
echo

flatpak search $pkg
