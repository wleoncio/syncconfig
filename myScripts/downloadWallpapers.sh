#!/bin/bash
# Uses RedditImageGrab (<https://github.com/HoverHell/RedditImageGrab>) to download wallpapers
subs='Verticalwallpapers HDwallpapers F1porn wallpaper wallpapers'

for sub in $subs
do
	python ~/Programs/RedditImageGrab/redditdl.py $sub ~/Bilder/Wallpapers --num 10 --sfw --update --filename-format png
done
