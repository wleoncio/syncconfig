#!/bin/bash
# Updates NEWS.md and commits change

xdg-open NEWS.md
read -p "Commit changes? [Y/n] " commit

if [ "$commit" != "n" ]
then
	git add NEWS.md
	git commit --message "Updated NEWS.md"
fi

