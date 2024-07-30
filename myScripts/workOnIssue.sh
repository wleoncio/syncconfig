#!/bin/bash
# Starts working on a GitHub issue

issue_number=$1

# Checking if issue branch already exists
if [ $(git branch | grep issue-"$issue_number") ]
then
	echo "Branch already exists. Switching and rebasing"
	bash resumeWorkOnIssue.sh "$issue_number"
	exit 0
fi	

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
echo "####################"
echo "# Summary of issue #"
echo "####################"
echo ""
gh issue view "$issue_number"
