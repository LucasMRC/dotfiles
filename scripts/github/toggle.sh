#!/bin/bash

if [ ! -f /tmp/gh_notifications ]; then
    touch /tmp/gh_notifications
    echo "Github notifications service started."
else
    rm /tmp/gh_notifications
    echo "Github notifications service stopped."
fi
