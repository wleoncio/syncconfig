#!/bin/bash
# Starts working on a GitHub issue

issueNumber=$1

echo "Self-assigning issue on GitHub"
gh issue edit "$issueNumber" --add-assignee @me

echo "Crating and checking out branch"
git checkout -b issue-"$issueNumber"

echo "Updating build number"
Rscript -e "usethis::use_version('dev')"
new_dev_version=$(cat DESCRIPTION | grep Version: | cut -d " " -f 2)
git commit --all --message "Increment version number to "$new_dev_version""

echo "Summary of issue"
gh issue view "$issueNumber"

