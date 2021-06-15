#!/bin/bash

i3blocksconf=$HOME/.config/i3/i3blocks.conf
pavuline=$(awk '/pavucontrol/{ print NR; exit}' "$i3blocksconf")
iconline=$(($pavuline + 1))

# TODO: finish implementation. Replace $iconline on $i3blocksconf with one of these:     
