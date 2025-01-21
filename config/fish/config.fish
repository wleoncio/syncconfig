if status is-interactive
	# Commands to run in interactive sessions can go here
	source $HOME/.bash_aliases
	fish_add_path $HOME/Programs/syncconfig/
end

starship init fish | source
zoxide init --cmd cd fish | source

# Fish vim config
fish_vi_key_bindings default
set fish_cursor_default block blink

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block blink

# Set the insert mode cursor to a line
set fish_cursor_insert line blink
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore blink
set fish_cursor_replace underscore blink
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external line blink
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block blink
