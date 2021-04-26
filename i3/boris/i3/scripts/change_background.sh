#!/bin/bash

if [ $1 == 0 ]
then
	nitrogen --head=0 --save --set-zoom-fill --random .config/variety/
elif [ $1 == 1 ]
then
	nitrogen --head=1 --save --set-zoom-fill --random .config/variety/Downloaded/reddit_www_reddit_com_r_Verticalwallpapers/
else
	nitrogen --head=0 --save --set-zoom-fill --random .config/variety/
	nitrogen --head=1 --save --set-zoom-fill --random .config/variety/Downloaded/reddit_www_reddit_com_r_Verticalwallpapers/
fi

