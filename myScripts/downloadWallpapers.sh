#!/bin/bash
# Uses RedditImageGrab (https://github.com/HoverHell/RedditImageGrab) to download wallpapers
subs='Verticalwallpapers HDwallpapers F1porn wallpaper wallpapers highreswallpaper 4kWallpaper threescreenwallpapers multiwall'

for sub in $subs
do
	python ~/Programs/RedditImageGrab/redditdl.py $sub ~/Bilder/Wallpapers --num 10 --sfw --update --filename-format png
done
