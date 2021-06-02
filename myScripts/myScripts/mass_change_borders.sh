#!/bin/bash
# This script changes the border width for the currently open and new windows.
# Author: Waldir Leoncio

i3conf=$HOME/.config/i3/config
i3-msg [class=.*] border pixel $1
sed -ir "s/set \$bordersize .\+/set \$bordersize $1/" $i3conf
i3-msg reload
