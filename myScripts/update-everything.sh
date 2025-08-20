# /bin/bash
# Checks everythin in the system for upgrades

# Picking up OS package manager
package_manager_name=""
package_manager_path=""
if [ -e /bin/yay ]; then
	package_manager_name="Yay"
	package_manager_command="yay -Syu"
elif [ -e /bin/nala ]; then
	package_manager_name="Nala"
	package_manager_command="nala upgrade --assume-yes"
fi

# Checking for upgrades
sudo --validate
if [ -n "$package_manager_name" ]; then 
	echo -e "# " $package_manager_name "\n"
	$package_manager_command
fi

if [ -e /bin/snap ]; then
	echo -e "# Snap\n"
	sudo snap refresh
fi

if [ -e /bin/flatpak ]; then
	echo -e "# Flatpak\n"
	flatpak update --assumeyes
fi

if [ -e /bin/gh ]; then
	echo -e "# GitHub CLI\n"
	gh extension upgrade --all
fi
