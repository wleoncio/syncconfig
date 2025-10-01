#!/usr/bin/env bash

# m4_ignore(
echo "This is just a script template, not the script (yet) - pass it to 'argbash' to fix this." >&2
exit 11  #)Created by argbash-init v2.11.0
# ARG_POSITIONAL_SINGLE([stash_message], [Message for the stash push], )
# ARG_POSITIONAL_SINGLE([new_branch], [Name of the new branch to switch to], )
# ARG_DEFAULTS_POS
# ARG_HELP([Quickly switch between tasks that should belong to different branches])
# ARG_VERSION([echo $0 v0.1.0])
# ARGBASH_SET_INDENT([  ])
# ARGBASH_GO

# [ <-- needed because of Argbash

# vvv  PLACE YOUR CODE HERE  vvv

echo "Stashing working directory"
git stash push --all --message "$1"

echo "Checking out branch $2"
git checkout -b $2

# ^^^  TERMINATE YOUR CODE BEFORE THE BOTTOM ARGBASH MARKER  ^^^

# ] <-- needed because of Argbash
