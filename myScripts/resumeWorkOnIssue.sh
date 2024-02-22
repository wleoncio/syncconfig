#!/bin/bash
# Continue working on a GitHub issue

issue_number=$1

echo "#######################"
echo "# Checking out branch #"
echo "#######################"
echo ""
git checkout issue-"$issue_number"

echo ""
echo "#########################"
echo "# Rebasing with develop #"
echo "#########################"
echo ""
git rebase develop

echo ""
echo "#########################"
echo "# Updating build number #"
echo "#########################"
echo ""
Rscript -e "usethis::use_version('dev')"
new_dev_version=$(cat DESCRIPTION | grep Version: | cut -d " " -f 2)
git commit --all --message "Increment version number to "$new_dev_version""

echo ""
echo "####################"
echo "# Summary of issue #"
echo "####################"
echo ""
gh issue view "$issue_number"
