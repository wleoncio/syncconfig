#!/bin/bash
# Starts working on a GitHub issue

issueNumber=$1

echo "Self-assigning issue on GitHub"
gh issue edit "$issueNumber" --add-assignee @me

echo "Crating and checking out branch"
git checkout -b issue-"$issueNumber"

