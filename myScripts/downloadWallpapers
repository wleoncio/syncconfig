#!/bin/bash
# Uses RedditImageGrab (https://github.com/wleoncio/RedditImageGrab) to download wallpapers

# Variables
subs='DualMonitorWallpapers'
script=~/Programs/RedditImageGrab/redditdl.py
outpath=~/Bilder/Wallpapers
opts="--num 10 --sfw --filename-format png"

# Looping through the subs to download wallpapers
for sub in $subs
do
	python3 $script $sub $outpath $opts
done
