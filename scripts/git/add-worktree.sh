#!/usr/bin/env bash

set -ef -o pipefail

# if not in a git repository, this will fail and exit
(git rev-parse)

function usage {
	cat << EOF
Create a new worktree on a bare repository.

Usage:
	$0 <BRANCH> [ORIGIN]
Examples:
	$0 new-feature
	$0 new-feature develop
EOF
}

if [[ $# -ne 1 && $# -ne 2 ]]; then
	usage
	exit 2
fi

BRANCH=$1
ORIGIN=$2
CURR_D=$(pwd)

if [[ -z "$BRANCH" ]]; then
	echo "You have to specify a branch name"
	exit 1
fi

# Go to bare repo root directory
cd $(git rev-parse --git-common-dir)

echo "Creating new worktree..."

if [[ -z "$ORIGIN" ]]; then
	MAIN=$(git branch | grep -E '(main|master)' | gawk 'match($0, /master|main/) {print $2}')
	ORIGIN="origin/$MAIN"
	git fetch origin "$MAIN"
fi

git worktree add -b "$BRANCH" "$BRANCH" "$ORIGIN"
