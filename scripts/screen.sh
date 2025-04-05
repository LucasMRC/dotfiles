#!/bin/bash
LAYOUTS_DIR=~/.screenlayout
LAYOUT=$1
if [ -z $LAYOUT ]; then
    LAYOUT='screen_default'
fi
DEFAULT_LAYOUT=$(ls $LAYOUTS_DIR | grep $LAYOUT)

sh "$LAYOUTS_DIR/$DEFAULT_LAYOUT"
feh --bg-max --randomize ~/.desktop/
