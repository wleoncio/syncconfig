#!/bin/bash
# Starts working on a GitHub issue

issue_number=$1

echo "##################################"
echo "# Self-assigning issue on GitHub #"
echo "##################################"
echo ""
gh issue edit "$issue_number" --add-assignee @me

echo ""
echo "####################################"
echo "# Creating and checking out branch #"
echo "####################################"
echo ""
git checkout -b issue-"$issue_number"

echo ""
echo "################################"
echo "# Package coverage at checkout #"
echo "################################"
echo ""
Rscript -e "covr::percent_coverage(covr::package_coverage())"

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
