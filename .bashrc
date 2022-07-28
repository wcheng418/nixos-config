if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Path
export PATH="$HOME/.scripts/:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

# Aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias top='btop'

alias poweroff='loginctl poweroff'
alias reboot='loginctl reboot'

alias youtube-dl='yt-dlp'
alias yt='ytfzf --loop'

alias cfup='doas wg-quick up cloudflare'
alias cfdown='doas wg-quick down cloudflare'

# doas completion
complete -cf doas

export PS1="\[\e[0;31m\][\[\e[0;33m\]\u\[\e[0;32m\]@\[\e[0;34m\]\h \[\e[0;35m\]\W\[\e[0;31m\]]\[\e[0;0m\]$ "
