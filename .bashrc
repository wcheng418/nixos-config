[[ $- != *i* ]] && return

alias hx='helix'
alias yt='ytfzf --loop'
alias youtube-dl='yt-dlp'

alias pacman='paru'
alias find='fd'
alias top='btm'
alias ls='exa'
alias cat='bat'
alias grep='rg'
alias sed='sd'
alias du='dust'

alias cfup='wg-quick up cloudflare'
alias cfdown='wg-quick down cloudflare'

export PS1="\[\e[0;31m\][\[\e[0;33m\]\u\[\e[0;32m\]@\[\e[0;34m\]\h \[\e[0;35m\]\W\[\e[0;31m\]] \[\e[0m\]"
