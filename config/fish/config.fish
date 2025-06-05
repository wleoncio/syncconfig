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

	# RSE-related quotes on work machine instead of fish greet
	if test $hostname = "imb-0646";
		gh inspire | awk '
			/^~/ {
				gsub(/^~ /, "", $0)
				gsub(/\033\[[0-9;]*m/, "", $0)
				print > "/tmp/author.txt"
			}
			{ print }
		'
		cat /tmp/author.txt | tgpt --quiet "Please tell me, in one short sentence, about this quote author. Please start your answer with 'a'. Put the entire answer between ()" --provider isou
		set fish_greeting
	end


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

# Created by `pipx` on 2025-06-03 08:24:23
set PATH $PATH /home/waldir/.local/bin
