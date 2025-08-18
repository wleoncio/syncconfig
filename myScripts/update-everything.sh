# /bin/bash
# Checks everythin in the system for upgrades

# Picking up OS package manager
package_manager_name=""
package_manager_path=""
if [ -e /bin/yay ]; then
	package_manager_name="Yay"
	package_manager_command="/bin/yay -Syu"
elif [ -e /bin/nala ]; then
	package_manager_name="Nala"
	package_manager_command="/bin/nala upgrade --assume-yes"
fi

 # TODO: check if snap exists
 # TODO: check if flatpak exists
 # TODO: check if gh exists

# Checking for upgrades
sudo --validate
if [ -n "$package_manager_name" ]; then 
	echo -e '\# "$package_manager_name"'
	$package_manager_command
fi
