#!/bin/bash
# Continue working on a GitHub issue

issue_number=$1

git checkout issue-"$issue_number"
git rebase develop

echo ""
echo "####################"
echo "# Summary of issue #"
echo "####################"
echo ""
gh issue view "$issue_number"
