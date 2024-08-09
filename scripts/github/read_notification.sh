#!/bin/bash

if [ -z $1 ]; then
    echo "No thread id specified"
    exit 1
fi

TOKEN=$(cat ~/.dotfiles/scripts/github/gh.pass)
THREAD_ID=$1

curl --request PATCH \
        --url "https://api.github.com/notifications/threads/$THREAD_ID" \
        --header "Accept: application/vnd.github+json" \
        --header "Authorization: Bearer $TOKEN"

echo "Notification $THREAD_ID marked as read"
