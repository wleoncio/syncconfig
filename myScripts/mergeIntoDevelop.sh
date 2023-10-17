#!/usr/bin/bash
# Script to merge feature branches into develop

# Usage
echo "Usage: $(basename $0) [options]" 2>&1
echo "	-t	Skips unit test coverage check"
echo "	-v	Skips version bump"
echo ""

# Parsing options
covr=true
version=true
while getopts "tv" option; do
	case "$option" in
		t) covr=false ;;
		v) version=false ;;
		?) echo "Invalid option: -${OPTARG}" ;;
	esac
done

feature_branch=$(eval git branch --show-current)

echo "Unstaged modifications:"
git status --short

if [ $covr == true ]; then
	echo "Package coverage on merge"
	Rscript -e "cat(covr::percent_coverage(covr::package_coverage()))"
fi

echo "Merging $feature_branch into develop. Did you remember to:"
read -p $'\e[4;31mSquash\e[0m commits on the feature branch?'
read -p $'Add \e[4;31munit tests\e[0m for new code?'
read -p $'Update \e[4;31mNEWS\e[0m.md?'
git checkout develop
git merge $feature_branch --log

if [ $version == true ]; then
	echo "Incrementing build number"
	Rscript -e "usethis::use_version('build')"
fi
