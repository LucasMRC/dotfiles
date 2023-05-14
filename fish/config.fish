if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Supresses fish's intro message
set fish_greeting

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias code='code-insiders'
alias standing-setup='sh /home/lucas/.screenlayout/standing-setup.sh'

if [ -f /usr/bin/neofetch ]
    neofetch | lolcat
end

# Set up ssh-agent with GH key
if [ -z "$SSH_AUTH_SOCK" ]
    eval "$(ssh-agent -c)" &>/dev/null
    ssh-add -q ~/.ssh/id_ed25519_GH
end