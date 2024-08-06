#!/bin/bash
picom &
# setup the screen layout before the xhost command, otherwise xrandr will be weird
sh ~/.config/scripts/screen.sh
# allow lucas to use X, I need this for the cron job that changes the wallpaper
xhost +si:localuser:lucas &
setxkbmap -layout us -variant intl # Keyboard layout
gsettings set org.gtk.Settings.FileChooser window-size '(800,600)' # Set default file chooser windows size
v4l2-ctl -d /dev/video0 --set-ctrl brightness=100 # Set camera brightness
v4l2-ctl -d /dev/video0 --set-ctrl contrast=25 # Set camera contrast
systemctl --user start spotifyd # For some reason fails when started as enabled service
