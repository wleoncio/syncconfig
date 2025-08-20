# /bin/bash
# Checks everythin in the system for upgrades

# Picking up OS package manager
package_manager_name=""
package_manager_path=""
if [ -e /bin/yay ]; then
	package_manager_name="Yay "
	package_manager_command="yay -Syu"
elif [ -e /bin/nala ]; then
	package_manager_name="Nala"
	package_manager_command="sudo nala upgrade --assume-yes"
fi

bold_orange=$(tput bold; tput setaf 3)
normal=$(tput sgr0)

# Checking for upgrades
sudo --validate
if [ -n "$package_manager_name" ]; then 
	printf "${bold_orange}# %s ###########################################${normal}\n" "$package_manager_name"
	$package_manager_command
fi

if [ -e /bin/snap ]; then
	printf "\n${bold_orange}# Snap ###########################################${normal}\n"
	sudo snap refresh
fi

if [ -e /bin/flatpak ]; then
	printf "\n${bold_orange}# Flatpak ########################################${normal}\n"
	flatpak update --assumeyes
fi

if [ -e /bin/gh ]; then
	printf "\n${bold_orange}# GitHub CLI #####################################${normal}\n"
	gh extension upgrade --all 
fi

# TODO: consider adding R packages with
# Rscript -e "update.packages(lib.loc=.libPaths()[1], ask=FALSE)"
