if status is-interactive
  # Commands to run in interactive sessions can go here
	source $HOME/.bash_aliases
	fish_add_path $HOME/Programs/syncconfig/
	if test $hostname = "imb-0646";
		cd $HOME/UiO/Projects;
	end
end

# Terminal add-ons
starship init fish | source
zoxide init --cmd cd fish | source
thefuck --alias | source

# Fish vim config ("default" == normal)
set fish_cursor_default block blink
set fish_cursor_insert line 
set fish_cursor_replace_one block blink
set fish_cursor_replace block blink

# Override Alacritty cursors
set fish_vi_force_cursor 

# Start on insert mode
fish_vi_key_bindings insert
