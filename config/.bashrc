# Don't do anything for non-interative or root sessions
[[ $- != *i* ]] && return
[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100  # limits recursive functions, see 'man bash'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Custom PS1
_set_my_PS1() {
  	PS1='\e[33m$(parse_git_branch)\e[0m \[\033[1;30;44m\] \w \[\033[0;37m\]\e[0m '
    echo -e "\e]12;lightgray\a" # cursor format
}

_set_my_PS1
unset -f _set_my_PS1

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Linking custom scripts to $PATH
ln -f $HOME/Programs/syncconfig/myScripts/* $HOME/.local/bin
ln -f $HOME/Programs/syncconfig/syncconfig $HOME/.local/bin

# Environment variables
export PATH=$PATH:~/.local/bin:~/.cargo/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/MATLAB/2023b/bin/glnxa64
export COLUMNS

# Enabling Bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/waldir/Programs/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/waldir/Programs/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/waldir/Programs/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/waldir/Programs/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Starting zoxide (replaces cd) and fzf
eval "$(zoxide init bash)"
eval "$(fzf --bash)"

# Enable superfile "cd on quit" (https://superfile.dev/configure/superfile-config/#cd_on_quit)
spf() {
	export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
	command spf "$@"
	[ ! -f "$SPF_LAST_DIR" ] || {
		. "$SPF_LAST_DIR"
		rm -f -- "$SPF_LAST_DIR" > /dev/null
	}
}
