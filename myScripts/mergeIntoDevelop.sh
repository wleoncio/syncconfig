#! /bin/bash
# Script to merge feature branches into develop

feature_branch=$(eval git branch --show-current)
echo "Merging $feature_branch into develop. Did you remember to:"
read -p $'Added \e[4;31munit tests\e[0m for new code?'
read -p $'Incremented the build \e[4;31mversion\e[0m number?'
read -p $'Updated \e[4;31mNEWS\e[0m.md?'
git checkout develop
git merge $feature_branch
