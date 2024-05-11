#!/bin/bash
picom &
# setup the screen layout before the xhost command, otherwise xrandr will be weird
sh ~/.config/scripts/standing-setup.sh
# allow lucas to use X, I need this for the cron job that changes the wallpaper
xhost +si:localuser:lucas &
ferdium &
/opt/brave-bin/brave --profile-directory=Default --app-id=pacgdjiidkfdhilcljkeebfoklekebig &
/opt/brave-bin/brave --profile-directory=Default --app-id=hkhckfoofhljcngmlnlojcbplgkcpcab &
spotifyd &
