#!/usr/bin/bash
# Script to merge feature branches into develop

source uio-colors.sh

# Usage
echo -e "Usage: $(basename $0) [options] [target_branch]" 2>&1
echo -e "\t-t\t\tSkips unit test coverage check"
echo -e "\t-v\t\tBumps build version after merge"
echo -e "\ttarget_branch\tBranch to merge into (default: develop)"
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

shift $((OPTIND-1))

# Determine target branch: use argument, or search for develop/main/master (local only)
if [[ -n $1 ]]; then
	target_branch="$1"
else
	branches=$(git branch --list)
	if echo "$branches" | grep -q develop; then
		target_branch="develop"
	elif echo "$branches" | grep -q main; then
		target_branch="main"
	elif echo "$branches" | grep -q master; then
		target_branch="master"
	else
		echo "Error: No suitable base branch found (develop, main, or master). Please specify a branch."
		exit 1
	fi
fi

# Warn if the user entered a non-existent branch (before proceeding)
if ! git branch --list | grep -q "$target_branch"; then
	echo -e "${roed}Error: Branch '$target_branch' does not exist locally.${reset}"
	exit 1
else
	echo -e "\nUsing target branch: ${blaa}${target_branch}${reset}\n"
fi

feature_branch=$(eval git branch --show-current)

# Making sure pre-work is done

unstaged=$(eval git status --short)
if [ -n "$unstaged" ]; then
	echo "Unstaged modifications:"
	git status --short
	echo
	read -p "Press enter to continue, Ctrl+C to cancel"
fi

echo -e "\nMerging ${blaa}${feature_branch}${reset} into ${blaa}${target_branch}${reset}. Did you remember to:"

echo -e "- ${roed}Squash${reset} commits on the feature branch?"
git log --oneline $target_branch.. | grep -i -e "squash" -e "fixup"

echo -e "- Add unit ${roed}tests${reset} for new code?"
if [[ $covr == true && -f "DESCRIPTION" ]]; then
	echo -n "  Calculating package coverage on merge: "
	cvrg=$(Rscript -e "cat(round(covr::percent_coverage(covr::package_coverage()), 2))")
	echo -e "${roed}$cvrg %${reset}"
fi

if [[ -f "NEWS.md" ]]; then
	echo -e '- Update ${roed}NEWS${reset}.md (see head below)?'
	echo ""
	awk '/^#/ {c++; if (c==2) {exit}} {print}' NEWS.md
	echo ""
else
	echo -e "- ${roed}No NEWS.md${reset} found. Consider using one!"
fi

read -p "Press enter to continue, Ctrl+C to cancel"

git checkout $target_branch
git merge $feature_branch --log

if [ $version == true ]; then
	echo "Incrementing build number"
	Rscript -e "usethis::use_version('dev')"
fi
