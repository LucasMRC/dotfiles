#!/bin/bash
# This script was written to handle pomodoro sessions using the stretchly app.

POMODORO_ACTIVE=$(pgrep -f stretchly | head -1)

# Using a temporary file to store whether the pomodoro is paused or not.
POMODORO_PAUSED=/tmp/pomodoro_paused

# If the pomodoro is active, toggle it.
if [[ -n $POMODORO_ACTIVE ]]; then
    stretchly toggle

    # If the pomodoro is paused, resume it. Otherwise, pause it.
    if [ -f $POMODORO_PAUSED ]; then
        notify-send "Stretchly resumed" -i "/home/lucas/.config/scripts/stretchly.svg"
        rm $POMODORO_PAUSED
    else
        notify-send "Stretchly paused" -i "/home/lucas/.config/scripts/stretchly-paused.svg"
        touch $POMODORO_PAUSED
    fi

else
    # If the pomodoro is not active, start it.
    stretchly >> /dev/null 2>&1 &
    notify-send "Stretchly started" -i "/home/lucas/.config/scripts/stretchly.svg"
fi
