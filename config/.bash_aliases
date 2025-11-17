# Coding shortcuts
alias work="gh dash"
alias r="~/venv/bin/radian"
alias cleanR="sudo docker run --rm -ti r-base bash"
alias matlab-cli="/usr/local/bin/matlab -nodesktop -nosplash"
alias gt="git"
alias quem\?="cat /tmp/author.txt | tgpt --quiet 'Who is this person from the world of software development?' --provider isou"

# System shortcuts
alias nvtop="watch -d -n 0.5 nvidia-smi"
alias open="xdg-open"
alias copy="xclip -selection clipboard"
alias bt="bluetoothctl"
alias update="update-everything"
alias connect="nmcli connection up eduroam"
alias lstar="tar -ztvf"
alias ls="eza"
alias lsl="eza --long --no-user --git"
alias lsa="eza --all"
alias lsal="eza --long --no-user --git --all"
alias lsla=lsal
alias lst="eza --tree --level 2"
alias pqp="fuck"
alias fd="fdfind"
alias tree="ls --tree"

# UiO server ops
alias pushuio="uiosync push"
alias pulluio="uiosync pull"
alias smaug="ssh waldirln@login.uio.no"
alias mb="ssh waldirln@login.uio.no -t ssh med-biostat"
alias mb2="ssh waldirln@login.uio.no -t ssh med-biostat2"
alias fox="ssh ec-waldirln@fox.educloud.no"

# Common folders
alias tmp="cd /tmp"

# LLMs
alias ai="tgpt --interactive"
alias mistral="ollama run mistral"

# Environment variables hidden on .sensitive_env (uncommited) 
[ -f "$HOME/.sensitive_env" ] && source "$HOME/.sensitive_env"
