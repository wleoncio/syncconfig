#!/bin/bash

# Reading input
read -p "Enter term for searching: " term
read -p "Select language: 1 for English, 2 for Norwegian: " language

# Forming URL
if [ "$language" -eq 1 ]
then
	url="https://www.merriam-webster.com/dictionary/"$term""
else
	url="https://ordbokene.no/bm/search?q="$term""
fi

# Opening URL
exec firefox --new-window "$url"
