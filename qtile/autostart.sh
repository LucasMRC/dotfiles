#!/bin/bash
picom &
feh --bg-fill --randomize ~/.desktop/ & # set wallpaper on monitor 2
xhost +si:localuser:lucas & # allow lucas to use X