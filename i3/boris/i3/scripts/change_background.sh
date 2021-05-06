#!/bin/bash

if [ $1 == 0 ]
then
	nitrogen --head=0 --save --set-zoom-fill --random ~/Pictures/rid/
elif [ $1 == 1 ]
then
	nitrogen --head=1 --save --set-zoom-fill --random ~/Pictures/rid/
else
	nitrogen --head=0 --save --set-zoom-fill --random ~/Pictures/rid/
	nitrogen --head=1 --save --set-zoom-fill --random ~/Pictures/rid/
fi

