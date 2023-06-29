if status is-interactive
	# Commands to run in interactive sessions can go here
    set -U fish_greeting
	starship init fish | source
    set fish_vi_force_cursor 1
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block
end
