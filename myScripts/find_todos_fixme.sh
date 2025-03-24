#!/usr/bin/bash
grep --recursive --extended-regexp "#\s?(TODO|FIXME)" . --line-number --before-context=3 --after-context=3 --color=always
