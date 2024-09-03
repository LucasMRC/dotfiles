#!/bin/bash

# The cron job package that I'm using now is 'cronie'
# 'crontab -e' to edit the cron jobs, and '0 * * * *' to check every hour.

# export $(dbus-launch) # fixes Error spawning command line 'dbus-launch --autolaunch'
# fix 'Couldn't initialize x11 output' error
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
#

IDS_FILE=/tmp/gh_notifications

echo "================================================================================"

if [ ! -f $IDS_FILE ]; then
    echo "Github notifications script not started"
    exit 0
fi

TOKEN=$(cat ~/.dotfiles/scripts/github/gh.pass)

echo "Fetching notifications"
NOTIFICATIONS=$(curl --request GET \
    --url "https://api.github.com/notifications" \
    --header "Accept: application/vnd.github+json" \
    --header "Authorization: Bearer $TOKEN" \
    | jq -r '.[] | {"id": .id, "title": .subject.title, "url": .subject.url, "reason": .reason, "type": .subject.type}')

FETCHED_ID_STRING=$(jq <<< $NOTIFICATIONS | gawk 'match($0, /"([0-9]+)"/, ids) { print ids[1] }')

STORED_ID_STRING=$(cat $IDS_FILE)

for ID in $STORED_ID_STRING; do
    F_ARR=( $FETCHED_ID_STRING )
    if [[ ! ${F_ARR[@]} =~ $ID ]]; then
        STORED_ID_STRING=$(sed "s/$ID//" <<< $STORED_ID_STRING | sed "s/  / /")
    else
        FETCHED_ID_STRING=$(sed "s/$ID//" <<< $FETCHED_ID_STRING | sed "s/  / /")
    fi
done

COUNT=$(wc -w <<< $FETCHED_ID_STRING)
STORED_COUNT=$(wc -w <<< $STORED_ID_STRING)
INDEX=0
if [ $COUNT -gt "0" ]; then
    N_ALL=""
    for ID in $STORED_ID_STRING; do
        N_ALL+=$ID
        if [ $INDEX -lt $STORED_COUNT ]; then
            N_ALL+=" "
        fi
        ((INDEX++))
    done
    INDEX=0
    for ID in $FETCHED_ID_STRING; do
        N_ALL+=$ID
        if [ $INDEX -lt $COUNT ]; then
            N_ALL+=" "
        fi
        ((INDEX++))
    done
    echo $N_ALL > $IDS_FILE # Comment this line for testing
    echo "There's $COUNT new notifications"
    notify-send "There's $COUNT new notifications" -i "/home/lucas/.dotfiles/scripts/github/logo.png" -a "Github notifications"
else
    echo "No new github notifications"
fi
