#!/bin/bash
# Starts working on a GitHub issue

issue_number=$1

echo "##################################"
echo "# Self-assigning issue on GitHub #"
echo "##################################"
gh issue edit "$issue_number" --add-assignee @me

echo "####################################"
echo "# Creating and checking out branch #"
echo "####################################"
git checkout -b issue-"$issue_number"


echo "################################"
echo "# Package coverage at checkout #"
echo "################################"
Rscript -e "covr::package_coverage()"

echo "#########################"
echo "# Updating build number #"
echo "#########################"
Rscript -e "usethis::use_version('dev')"
new_dev_version=$(cat DESCRIPTION | grep Version: | cut -d " " -f 2)
git commit --all --message "Increment version number to "$new_dev_version""

echo "####################"
echo "# Summary of issue #"
echo "####################"
gh issue view "$issue_number"
