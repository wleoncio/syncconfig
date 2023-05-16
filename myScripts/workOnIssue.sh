#!/bin/bash
# Starts working on a GitHub issue

issueNumber=$1

echo "Self-assigning issue on GitHub"
gh issue edit "$issueNumber" --add-assignee @me

echo "Crating and checking out branch"
git checkout -b issue-"$issueNumber"

echo "Updating build number"
Rscript -e "usethis::use_version('dev')"
git commit --all --message "Updated build version number"

echo "Summary of issue"
gh issue view "$issueNumber"

