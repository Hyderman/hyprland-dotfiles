if status is-interactive
	# Commands to run in interactive sessions can go here
    set -U fish_greeting
	starship init fish | source
end

bind \en "nvim ."
alias cat="bat"
alias ls="lsd"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"


