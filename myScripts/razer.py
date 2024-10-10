#!/usr/bin/python
# Script to control the Razer Keyboard through polychromatic
import os
import sys

input = sys.argv[1]
if input == "reset":
    print("Resetting to defaults")
    os.system("polychromatic-cli -o game_mode -p 0")
    os.system("polychromatic-cli -o static -c '#0000FF'")
elif input == "game":
    print("Entering game mode")
    os.system("polychromatic-cli -o game_mode -p 1")
