#!/bin/bash

stremio %U &
sleep 10

WIN_ID=$(xwininfo -root -children | awk '{print $1 $2}' | grep Stremio | sed 's/"Stremio"://')

xdg-screensaver suspend $WIN_ID
echo "Suspended screensaver for window $WIN_ID"
