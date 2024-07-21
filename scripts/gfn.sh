#!/bin/bash

DOTFILES_DIR=/home/lucas/.dotfiles/
WEBSITE_DIR=/home/lucas/Repositories/grafana/website.git/

# Website
tmux new -d -s "Neovim" -n "Website" -c $WEBSITE_DIR "nvim ."
# Dotfiles
tmux neww -t "Neovim:2" -n "Dotfiles" -c $DOTFILES_DIR "nvim ."
# Obsidian
tmux neww -t "Neovim:3" -n "Notes" -c $DOTFILES_DIR "nvim ."
tmux send-keys -t "Neovim:Notes" Space no # open obsidian telescope extension

# Tasks
tmux new -d -s "Terminal" -n "Tasks" -c $WEBSITE_DIR
# Monitoring
tmux neww -t "Terminal:2" -n "HTOP" -c $DOTFILES_DIR "htop"
# Music player
tmux neww -t "Terminal:3" -n "Music" -c $DOTFILES_DIR "spotify_player"
tmux send-keys -t "Terminal:Music" gs # go to global search
# Github
tmux neww -t "Terminal:4" -n "Github" -c $WEBSITE_DIR "gh dash"

# Select main windows
tmux selectw -t "Terminal:Tasks"
tmux selectw -t "Neovim:Website"

# Attach
tmux a -t Neovim
