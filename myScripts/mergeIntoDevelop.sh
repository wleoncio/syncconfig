#! /bin/bash
# Script to merge feature branches into develop

feature_branch=$(eval git branch --show-current)
echo "Merging $feature_branch into develop. Did you remember to:"
read -p "Increment the build version number?"
read -p "Update NEWS.md?"
git checkout develop
git merge $feature_branch
