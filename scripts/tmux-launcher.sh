#!/bin/bash

DOTFILES_DIR=/home/lucas/.dotfiles/
WORKING_DIR=$(ls -d ~/Repositories/*/*/ | sed "s/^\/.*\/Repositories\///g" | fzf --preview 'ls -a ~/Repositories/{}' --preview-window 'right,wrap' | awk '{ print "/home/lucas/Repositories/"$1 }')

if [ ! $WORKING_DIR ]; then
	exit 1
fi

# Primary
tmux new -d -s "Neovim" -n "Primary" -c $WORKING_DIR
tmux send-keys -t "Neovim:Primary" "invim . --startuptime /home/lucas/.dotfiles/nvim/startuptime.log" Enter
# Github
tmux neww -t "Neovim:2" -n "Github" -c $WORKING_DIR
tmux send-keys -t "Neovim:Github" "invim ." Enter
tmux send-keys -t "Neovim:Github" C-q Space gn # open github notifications
# Dotfiles
tmux neww -t "Neovim:3" -n "Dotfiles" -c $DOTFILES_DIR
tmux send-keys -t "Neovim:Dotfiles" "invim ." Enter
# Obsidian
tmux neww -t "Neovim:4" -n "Notes" -c $DOTFILES_DIR
tmux send-keys -t "Neovim:Notes" "invim ." Enter
tmux send-keys -t "Neovim:Notes" Space no # open obsidian telescope extension

# Tasks
tmux new -d -s "Terminal" -n "Tasks" -c $WORKING_DIR

# Monitoring
tmux neww -t "Terminal:2" -n "HTOP" -c $DOTFILES_DIR
tmux send-keys -t "Terminal:HTOP" "ihtop" Enter
# Music player
# tmux neww -t "Terminal:3" -n "Music" -c $DOTFILES_DIR
# tmux send-keys -t "Terminal:Music" "ispotify_player" Enter

# Select main windows
tmux selectw -t "Terminal:Tasks"
tmux selectw -t "Neovim:Primary"

# Attach
tmux a -t Neovim
