if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace     underscore
    set fish_cursor_visual      block
    function fish_user_key_bindings
        fish_vi_key_bindings default
        bind --preset -M visual -m insert i kill-selection end-selection repaint-mode
        bind --preset -M visual -m default v kill-selection end-selection repaint-mode
        bind --preset -M insert -m default \cc cancel-commandline repaint-mode

        bind --erase --preset -M default o
        bind --erase --preset -M default O

        bind --erase --preset -M default \cc
        bind --erase --preset :q
    end
end
# Set normal mode as the default
for mode in default insert visual
  bind -M $mode \r -m default execute
end

# Supresses fish's intro message
set fish_greeting

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
    
# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto -i'
alias pdf='mupdf'
alias hist='history --show-time="%d/%m/%Y %T " | less'
alias vbox-enable='sudo modprobe vboxnetadp'
alias :q='exit'
alias tmux-launcher='sh ~/.config/scripts/tmux-launcher.sh'
alias RM='rm -rf'
alias rm='trash'
alias g='sh ~/.config/scripts/gfn.sh'
alias ghn='sh ~/.config/scripts/github/toggle.sh'

# Set up arandr layout aliases
set SCREENS (ls ~/.screenlayout/ | sed 's/.sh//g')
for SCREEN in $SCREENS
    alias $SCREEN="sh ~/.config/scripts/screen.sh $SCREEN"
end

# if [ -f /usr/bin/neofetch ]
    # neofetch | lolcat
# end

# Set up ssh-agent service
if [ -z "$SSH_CONNECTION" ]
  set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
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
