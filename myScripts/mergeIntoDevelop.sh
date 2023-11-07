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

# Making sure pre-work is done


unstaged=$(eval git status --short)
if [ -n "$unstaged" ]; then
	echo "Unstaged modifications:"
	git status --short
fi

echo "Merging $feature_branch into develop. Did you remember to:"

echo -e '- \e[4;31mSquash\e[0m commits on the feature branch?'
git log --grep "squash" --grep "fixup"

echo -e '- Add \e[4;31munit tests\e[0m for new code?'
if [ $covr == true ]; then
	cvrg=$(Rscript -e "cat(covr::percent_coverage(covr::package_coverage()))")
	echo "  Package coverage on merge: $cvrg"
fi

echo -e '- Update \e[4;31mNEWS\e[0m.md (see head below)?'

head NEWS.md
echo ""

read -p "Press enter to continue, Ctrl+C to cancel"

git checkout develop
git merge $feature_branch --log

if [ $version == true ]; then
	echo "Incrementing build number"
	Rscript -e "usethis::use_version('build')"
fi
