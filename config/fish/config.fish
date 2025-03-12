function fish_title
		set --query argv[1]; or set argv "Terminal"
		if test $argv = "Terminal"
	    echo $argv
		else
			echo (fish_prompt_pwd_dir_length=0 prompt_pwd): $argv;
		end
end

if status is-interactive
  # Commands to run in interactive sessions can go here
	source $HOME/.bash_aliases
	fish_add_path $HOME/Programs/syncconfig/

	# Terminal add-ons
	starship init fish | source
	zoxide init --cmd cd fish | source
	thefuck --alias | source
	fzf --fish | source
end

# Fish vim config ("default" == normal)
set fish_cursor_default block blink
set fish_cursor_insert line 
set fish_cursor_replace_one block blink
set fish_cursor_replace block blink

# Override Alacritty cursors
set fish_vi_force_cursor 

# Start on insert mode
fish_vi_key_bindings insert

# Startup brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
