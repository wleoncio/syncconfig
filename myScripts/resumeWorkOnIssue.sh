#!/bin/bash
# Continue working on a GitHub issue

issue_number=$1

git checkout issue-"$issue_number"
git rebase develop
Rscript -e "usethis::use_version('dev')"
new_dev_version=$(cat DESCRIPTION | grep Version: | cut -d " " -f 2)
git commit --all --message "Increment version number to "$new_dev_version""

echo ""
echo "####################"
echo "# Summary of issue #"
echo "####################"
echo ""
gh issue view "$issue_number"
