if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set vi mode
function fish_user_key_bindings
    fish_vi_key_bindings default
end
# Set normal mode as the default
for mode in default insert visual
  bind -M $mode \r -m default execute
end

# Supresses fish's intro message
set fish_greeting

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias standing-setup='sh /home/lucas/.config/scripts/standing-setup.sh'
alias sitting-setup='sh /home/lucas/.config/scripts/sitting-setup.sh'
alias laptop-only='sh /home/lucas/.config/scripts/laptop-only.sh'
alias pdf='mupdf'
alias hist='history --show-time="%d/%m/%Y %T " | less'
alias conda-activate='eval ~/anaconda3/bin/conda "shell.fish" "hook" $argv | source'
alias vbox-enable='sudo modprobe vboxnetadp'

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
set -gx EDITOR nvim

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/lucas/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -gx NPM_GLOBAL "/home/lucas/.npm-global/bin"
if not string match -q -- $NPM_GLOBAL $PATH
  set -gx PATH "$NPM_GLOBAL" $PATH
end
