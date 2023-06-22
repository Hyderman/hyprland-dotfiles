if status is-interactive
	# Commands to run in interactive sessions can go here
    set -U fish_greeting
	starship init fish | source
    bind \ce 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'
end

fish_add_path /home/hyderman/.local/bin
# set -Ux QT_QPA_PLATFORM wayland
# set -Ux QT_QPA_PLATFORMTHEME qt5ct
