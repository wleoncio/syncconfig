#!/bin/bash
# Starts working on a GitHub issue

issueNumber=$1
gh issue edit "$issueNumber" --add-assignee @me
git checkout -b issue-"$issueNumber"

