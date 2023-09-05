#!/bin/bash
# Starts working on a GitHub issue

issue_number=$1

echo "Self-assigning issue on GitHub"
gh issue edit "$issue_number" --add-assignee @me

echo "Creating and checking out branch"
git checkout -b issue-"$issue_number"

echo "Package cover at checkout"
Rscript -e "covr::package_coverage()"

echo "Updating build number"
Rscript -e "usethis::use_version('dev')"
new_dev_version=$(cat DESCRIPTION | grep Version: | cut -d " " -f 2)
git commit --all --message "Increment version number to "$new_dev_version""

echo "Summary of issue"
gh issue view "$issue_number"
