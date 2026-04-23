#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export DATABASE_PASSWORD="TheCapturing3*"


# Pokémon Fetch for hyfetch
# 1. Define the function
fetch() {
    pokemon-colorscripts -r --no-title > /tmp/pokesprite
    fastfetch --logo /tmp/pokesprite
}

# 2. Call the function so it runs on login
fetch
