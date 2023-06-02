if status is-login
	if test (tty) = /dev/tty1
		wrappedhl
	end
end
if status is-interactive
	# Commands to run in interactive sessions can go here
	starship init fish | source
	alias r="ranger"
end
