#!/bin/bash

BRANCH=$1
ORIGIN=$2
CURR_D=$(pwd)

if [[ "$CURR_D" != *.git ]]; then
    echo "You have to be in the root directory of a git repository"
    exit 1
fi

if [ -z $BRANCH ]; then
    echo "You have to specify a branch name"
    exit 1
fi

echo "Creating new worktree..."

if [ -z $ORIGIN ]; then
    MAIN=$(git branch | grep -E '(main|master)' | gawk 'match($0, /master|main/) {print $2}')
    ORIGIN="origin/$MAIN"
	git fetch origin $MAIN
fi

git worktree add -b $BRANCH $BRANCH $ORIGIN
