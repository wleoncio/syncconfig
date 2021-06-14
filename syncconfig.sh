#! /bin/bash

# Script to manually sync files with GitHub
# Tip: edit the crontab file to make this run automatically

# ==============================================================================
# Determining computer name
# ==============================================================================
machinename=$(hostname)

# ==============================================================================
# Determining if operation is push or pull
# ==============================================================================
if [ "$1" = "push" ]
then
	echo "Pushing files to local git repository"
	fromto="to"
elif [ "$1" = "pull" ]
then
	echo "Pulling files from local git repository"
	fromto="from"
elif [ "$1" = "diff" ]
then
	echo "Pulling files from local git repository"
	fromto="from"
else
	echo "Comparing local files with local git repository"
	fromto="from"
fi

# ==============================================================================
# Determining location of GitHub files
# ==============================================================================
if [ "$2" = "" ]
then
	echo "Assuming git repository located at "$HOME/Programs". You can pass a different path as the second argument."
	location="$HOME/Programs/syncconfig"
else
	location="$2"
fi
if [ "$1" = "push" ] || [ "$1" = "pull" ]
then
	echo "Copying files "$fromto" "$location""
	echo "Copying i3 files "$fromto" "$location"/"$machinename""
fi

# ==============================================================================
# Determining VSC local folder
# ==============================================================================
has_vsc=true
if [ -d "$HOME/.config/VSCodium" ]
then
	VSCdir="VSCodium"
elif [ -d "$HOME/.config/VSCode" ]
then
	VSCdir="VSCode"
elif [ -d "$HOME/.config/Code - OSS" ]
then
	VSCdir="Code\ -\ OSS"
else
	echo "Could not determine location of VSCode directory."
	has_vsc=false
	
fi

# =============================================================================
# Determining i3 config folder
# =============================================================================
has_i3=true
if [ -d "$HOME/.i3" ]
then
	i3dir=".i3"
elif [ -d "$HOME/.config/i3" ]
then
	i3dir=".config/i3"
else
	echo "Could not determine location of i3 folder."
	has_i3=false
fi

# ==============================================================================
# Determining compositor
# ==============================================================================
if [ -f "$HOME/.config/picom.conf" ]
then
	echo "Compositor found: picom"
	compositor="picom.conf"
elif [ -f "$HOME/.config/compton.conf" ]
then
	echo "Compositor found: compton"
	compositor="compton.conf"
else
	echo "No supported compositor found (picom or compton)"
	compositor="other"
fi

# ==============================================================================
# Actually copying files
# ==============================================================================
if [ "$1" = "push" ]
then
	eval cp ~/.bash_aliases "$location"/config
	eval cp ~/.bashrc "$location"/config
	eval cp ~/.gitconfig "$location"/config
	eval cp ~/.radian_profile "$location"/config
	eval cp ~/.vimrc "$location"/config
	eval cp ~/.xbindkeysrc "$location"/config
	eval cp ~/.Xresources "$location"/config
	eval cp ~/.Rprofile "$location"/config
	if [ $compositor != "other" ]
	then
		eval cp ~/.config/"$compositor" "$location"/config
	fi
	eval cp ~/.config/gromit-mpx.cfg "$location"/config
 	eval cp ~/.config/dunst/dunstrc "$location"/config
	eval cp -r ~/Programs/myScripts/ "$location"/myScripts/
	if [ "$has_i3" = true ] 
	then
		eval cp -r ~/"$i3dir"/ "$location"/i3/"$machinename"/
	fi
	if [ "$has_vsc" = true ]
	then
		eval cp ~/.config/"$VSCdir"/User/keybindings.json "$location"/VSC
		eval cp ~/.config/"$VSCdir"/User/settings.json "$location"/VSC
		eval cp -r ~/.config/"$VSCdir"/User/snippets/ "$location"/VSC/
	fi
elif [ "$1" = "pull" ]
then
	eval cp "$location"/config/.bash_aliases ~
	eval cp "$location"/config/.bashrc ~
	eval cp "$location"/config/.gitconfig ~
	eval cp "$location"/config/.radian_profile ~
	eval cp "$location"/config/.vimrc ~
	eval cp "$location"/config/.xbindkeysrc ~
	eval cp "$location"/config/.Xresources ~
	eval cp "$location"/config/.Rprofile ~
	if [ $compositor != "other" ]
	then
		eval cp "$location"/config/"$compositor" ~/.config
	fi
	eval cp "$location"/config/gromit-mpx.cfg ~/.config
	eval cp "$location"/config/dunstrc ~/.config/dunst/
	eval cp -r "$location"/myScripts/* ~/Programs/myScripts/
	if [ "$has_i3" = true ] 
	then
		eval cp "$location"/i3/"$machinename"/* ~/"$i3dir"
	fi
	if [ "$has_vsc" = true ]
	then
		eval cp "$location"/VSC/keybindings.json ~/.config/"$VSCdir"/User
		eval cp "$location"/VSC/settings.json ~/.config/"$VSCdir"/User
		eval cp "$location"/VSC/snippets/r.json ~/.config/"$VSCdir"/User/snippets/
		eval cp -f "$location"/VSC/snippets/rmd.json ~/.config/"$VSCdir"/User/snippets/
	fi
else
	echo -e "\n# Diff report\n"
	diffFlags="--recursive --color=always"
	if [ "$1" = "diff" ]
	then
		echo -e "## Showing changes to be made when pulling\n"
		diffFlags=""$diffFlags" --suppress-common-lines -bZB -C 1"
	else
		echo -e "To get diff details, run this script with a 'diff' switch.\n"
		diffFlags=""$diffFlags" --brief --recursive"
	fi
	eval diff "$diffFlags" ~/.bash_aliases "$location"/config
	eval diff "$diffFlags" ~/.bashrc "$location"/config
	eval diff "$diffFlags" ~/.gitconfig "$location"/config
	eval diff "$diffFlags" ~/.radian_profile "$location"/config
	eval diff "$diffFlags" ~/.vimrc "$location"/config
	eval diff "$diffFlags" ~/.xbindkeysrc "$location"/config
	eval diff "$diffFlags" ~/.Xresources "$location"/config
	eval diff "$diffFlags" ~/.Rprofile "$location"/config
	eval diff "$diffFlags" ~/.config/compton.conf "$location"/config
	eval diff "$diffFlags" ~/.config/picom.conf "$location"/config
	eval diff "$diffFlags" ~/.config/gromit-mpx.cfg "$location"/config
 	eval diff "$diffFlags" ~/.config/dunst/dunstrc "$location"/config
	eval diff "$diffFlags" ~/Programs/myScripts "$location"/myScripts
	if [ "$has_i3" = true ]
	then
		eval diff "$diffFlags" -r ~/"$i3dir"/ "$location"/i3/"$machinename"/
	fi
	if [ "$has_vsc" = true ]
	then
		eval diff "$diffFlags" ~/.config/"$VSCdir"/User/keybindings.json "$location"/VSC/keybindings.json
		eval diff "$diffFlags" ~/.config/"$VSCdir"/User/settings.json "$location"/VSC/settings.json
		eval diff "$diffFlags" -f ~/.config/"$VSCdir"/User/snippets/ "$location"/VSC/snippets/
	fi
fi
