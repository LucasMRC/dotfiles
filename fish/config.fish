if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace     underscore
    set fish_cursor_visual      block
    function fish_user_key_bindings
        fish_vi_key_bindings 
        # bind -M visual i cancel repaint-mode
        # bind -M visual v cancel repaint-mode
    end
end
# Set normal mode as the default
for mode in default insert visual
  bind -M $mode \r -m default execute
end

# Supresses fish's intro message
set fish_greeting

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto -i'
alias standing-setup='sh /home/lucas/.config/scripts/standing-setup.sh'
alias sitting-setup='sh /home/lucas/.config/scripts/sitting-setup.sh'
alias laptop-only='sh /home/lucas/.config/scripts/laptop-only.sh'
alias pdf='mupdf'
alias hist='history --show-time="%d/%m/%Y %T " | less'
alias conda-activate='eval ~/anaconda3/bin/conda "shell.fish" "hook" $argv | source'
alias vbox-enable='sudo modprobe vboxnetadp'
alias :q='exit'
alias bruno='~/AppImages/Bruno/bruno_1.12.2_x86_64_linux.AppImage'
alias tmux-launcher='sh ~/.config/scripts/tmux-launcher.sh'
alias RM='rm'
alias rm='trash'

if [ -f /usr/bin/neofetch ]
    # neofetch | lolcat
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

# Kitty
set -gx KITTY_CONFIG_DIRECTORY "/home/lucas/.config/kitty"

# Connect to bluetooth
function bt
    set ADDRESS (bluetoothctl devices | grep $argv | awk '{print $2}')
    set CONNECTED (bluetoothctl info $ADDRESS | grep 'Connected: yes')
    if [ -z "$CONNECTED" ]
        bluetoothctl connect $ADDRESS
    else
        bluetoothctl disconnect $ADDRESS
    end
end
