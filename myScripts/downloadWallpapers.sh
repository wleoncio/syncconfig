#!/bin/bash
# Uses RedditImageGrab (https://github.com/arshjat/RedditImageGrab) to download wallpapers

# Variables
subs='Verticalwallpapers HDwallpapers F1porn wallpaper wallpapers highreswallpaper 4kWallpaper'
script=~/Programs/RedditImageGrab/redditdl.py
outpath=~/Bilder/Wallpapers
opts="--num 10 --sfw --filename-format png"

# Looping through the subs to download wallpapers
for sub in $subs
do
	python3 $script $sub $outpath $opts
done
