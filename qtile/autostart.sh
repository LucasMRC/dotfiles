#!/bin/bash
picom &
# setup the screen layout before the xhost command, otherwise xrandr will be weird
sh ~/.screenlayout/standing-setup.sh
# allow lucas to use X, I need this for the cron job that changes the wallpaper
xhost +si:localuser:lucas &
1password &