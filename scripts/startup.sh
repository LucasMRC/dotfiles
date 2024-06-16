#!/bin/bash
picom &
# setup the screen layout before the xhost command, otherwise xrandr will be weird
sh ~/.config/scripts/sitting-setup.sh
# allow lucas to use X, I need this for the cron job that changes the wallpaper
xhost +si:localuser:lucas &
brave --profile-directory="Profile 4" & # Open messages profile window
spotifyd &
setxkbmap -layout us -variant intl # Keyboard layout
gsettings set org.gtk.Settings.FileChooser window-size '(800,600)' # Set default file chooser windows size
