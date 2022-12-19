#!/bin/bash

read -p "Enter MM, MM YYYY or press enter for current month: " gcal_input
gcal -K $gcal_input
read -p "Press enter to exit"
