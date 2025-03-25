#!/usr/bin/bash
grep --recursive --extended-regexp "#\s?(TODO|FIXME)" . --line-number --context=3 --color=always
