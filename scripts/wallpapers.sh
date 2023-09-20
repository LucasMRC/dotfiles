#!/bin/bash
# Change wallpapers

# 'crontab -e' to edit the cron jobs, and '0 0 * * *' to run every hour.

export DISPLAY=:0

feh --bg-max --randomize ~/.desktop/
