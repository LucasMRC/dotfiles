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

function fish_prompt --description 'Write out the prompt'
	set -l last_pipestatus $pipestatus
	set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
	set -l normal (set_color normal)
	set -q fish_color_status
	or set -g fish_color_status red

	# Color the prompt differently when we're root
	set -l color_cwd $fish_color_cwd
	set -l suffix '>'
	if functions -q fish_is_root_user; and fish_is_root_user
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		end
		set suffix '#'
	end

	# Write pipestatus
	# If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
	set -l bold_flag --bold
	set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
	if test $__fish_prompt_status_generation = $status_generation
		set bold_flag
	end
	set __fish_prompt_status_generation $status_generation
	set -l status_color (set_color $fish_color_status)
	set -l statusb_color (set_color $bold_flag $fish_color_status)
	set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

	echo -n -s ' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status \n "~" $suffix " "
end

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto -i'
alias pdf='mupdf'
alias hist='history --show-time="%d/%m/%Y %T " | less'
alias vmware-enable='sudo modprobe -a vmw_vmci vmmon && sudo systemctl start vmware-networks.service & sudo systemctl start vmware-usbarbitrator.service'
alias :q='exit'
alias RM='rm -rf'
alias rm='trash'
alias lock='sh ~/.config/i3/lock.sh'
alias ghn='sh ~/.config/scripts/github/toggle.sh'
alias git-aw='sh ~/.config/scripts/git/add-worktree.sh'
alias git-bare='sh ~/.config/scripts/git/bare.sh'
alias tmux-launcher='sh ~/.config/scripts/tmux-launcher.sh'
alias m='man -k . | fzf --preview "echo {} | awk \'{ print $1 }\' | xargs man" --preview-window "right,wrap" | xargs man'
alias f='fzf --preview "cat {}" --preview-window "right,wrap" | xargs nvim'
alias t='sh ~/.config/scripts/tmux-launcher.sh'
alias vpn='sh ~/.config/scripts/vpn.sh'
alias keys-restore='setxkbmap -layout us -variant intl'

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
set -gx PAGER less

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
# set -gx KITTY_CONFIG_DIRECTORY "/home/lucas/.config/kitty"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/lucas/.local/bin/google-cloud-sdk/path.fish.inc' ];
# 	. "/home/lucas/.local/bin/google-cloud-sdk/path.fish.inc";
# end

# Load nvm
load_nvm > /dev/stderr
