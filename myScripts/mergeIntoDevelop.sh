#!/usr/bin/bash
# Script to merge feature branches into develop

# Usage
echo "Usage: $(basename $0) [options]" 2>&1
echo "	-t	Skips unit test coverage check"
echo "	-v	Bumps build version after merge"
echo ""

# Parsing options
covr=true
version=false
while getopts "tv" option; do
	case "$option" in
		t) covr=false ;;
		v) version=true ;;
		?) echo "Invalid option: -${OPTARG}" ;;
	esac
done

feature_branch=$(eval git branch --show-current)

# Making sure pre-work is done

unstaged=$(eval git status --short)
if [ -n "$unstaged" ]; then
	echo "Unstaged modifications:"
	git status --short
	read -p "Press enter to continue, Ctrl+C to cancel"
fi

echo "Merging $feature_branch into develop. Did you remember to:"

echo -e '- \e[4;31mSquash\e[0m commits on the feature branch?'
git log --oneline develop.. | grep -i -e "squash" -e "fixup"

echo -e '- Add \e[4;31munit tests\e[0m for new code?'
if [[ $covr == true && -f "DESCRIPTION" ]]; then
	echo -n "  Calculating package coverage on merge: "
	cvrg=$(Rscript -e "cat(round(covr::percent_coverage(covr::package_coverage()), 2))")
	echo "$cvrg %"
fi

if [[ -f "NEWS.md" ]]; then
	echo -e '- Update \e[4;31mNEWS\e[0m.md (see head below)?'
	echo ""
	awk '/^#/ {c++; if (c==2) {exit}} {print}' NEWS.md
	echo ""
else
	echo -e "- \e[4;31mNo NEWS.md\e[0m found. Consider using one!"
fi

read -p "Press enter to continue, Ctrl+C to cancel"

git checkout develop
git merge $feature_branch --log

if [ $version == true ]; then
	echo "Incrementing build number"
	Rscript -e "usethis::use_version('dev')"
fi
