if status is-interactive
	# Commands to run in interactive sessions can go here
    set -U fish_greeting
	starship init fish | source
	alias r="ranger"
    bind \ce "ranger"
end

fish_add_path /home/hyderman/.local/bin
# set -Ux QT_QPA_PLATFORM wayland
# set -Ux QT_QPA_PLATFORMTHEME qt5ct
