# Coding shortcuts
alias r="~/venv/bin/radian"
alias cleanR="sudo docker run --rm -ti r-base bash"
alias matlab="/usr/local/MATLAB/R2023b/bin/matlab -nodesktop -nosplash"
alias copilot="tgpt --interactive"
alias gt="git"

# System shortcuts
alias nvtop="watch -d -n 0.5 nvidia-smi"
alias open="xdg-open"
alias please="sudo"
alias copy="xclip -selection clipboard"
alias bt="bluetoothctl"
alias update="sudo nala update; sudo nala upgrade"
alias av="shutdown"
alias connect="nmcli connection up eduroam"
alias lstar="tar -ztvf"
alias ls="eza"
alias pqp="fuck"
alias cat="batcat --plain"
alias fd="fdfind"

# UiO servers
alias pushuio="uiosync.sh push"
alias pulluio="uiosync.sh pull"
alias smaug="ssh waldirln@login.uio.no"
alias mb="ssh waldirln@login.uio.no -t ssh med-biostat"
alias mb2="ssh waldirln@login.uio.no -t ssh med-biostat2"
alias fox="ssh ec-waldirln@fox.educloud.no"

# Common folders
alias work="cd $HOME/UiO/Projects"
alias sync="cd $HOME/Programs/syncconfig"
alias tmp="cd /tmp"

# Life shortcuts 
alias pump="python3 $HOME/Dropbox/Fitness/workoutPlan/start.py"
alias ai="tgpt --interactive --provider pollinations"
alias quem="cat /tmp/author.txt | tgpt --quiet 'Write a short sentence about this person from the world of software development' --provider isou"
