if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Supresses fish's intro message
set fish_greeting

# Set time for bash history
set HISTTIMEFORMAT "%d/%m/%y %T "

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias code='code-insiders'
alias standing-setup='sh /home/lucas/.screenlayout/standing-setup.sh'
alias sitting-setup='sh /home/lucas/.screenlayout/sitting-setup.sh'
alias pdf='mupdf'

if [ -f /usr/bin/neofetch ]
    neofetch | lolcat
end

# Set up ssh-agent with GH key
if [ -z "$SSH_AUTH_SOCK" ]
    eval "$(ssh-agent -c)" &>/dev/null
    ssh-add -q ~/.ssh/id_ed25519_GH
end

set fish_color_normal '#17a1a1'
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command '#17a1a1'
set fish_color_error '#ff6c6b'
set fish_color_param '#0070a3'

set __fish_git_prompt_show_informative_status true
set __fish_git_prompt_showcolorhints true
set __fish_git_prompt_char_dirtystate '*'
