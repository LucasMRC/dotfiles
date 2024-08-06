#!/bin/bash

echo "Cloning bare repository"
git clone --bare "$1" --depth=1
DIR=$2
if [ -z $DIR ]; then
    DIR=$(sed 's/.*\/\(.*\.git\)/\1/' <<< $1)
fi
echo "Adjusting origin fetch locations..."
cd $DIR && git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
echo "Success."
