#!/bin/bash
flameshot full --path /tmp/1.png
ffmpeg -i /tmp/1.png -vf boxblur=10 -loglevel warning -hide_banner -nostats -update 1 -vframes 1 /tmp/screenshot.png
rm /tmp/1.png
i3lock -i /tmp/screenshot.png
rm /tmp/screenshot.png
