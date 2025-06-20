#!/usr/bin/env bash

set -ef -o pipefail

function usage {
	cat << EOF
Clone a bare repository.

Usage:
	$0 <REPOSITORY> [DIRECTORY]
Examples:
	$0 git@github.com:grafana/website.git
EOF
}

if [[ $# -ne 1 && $# -ne 2 ]]; then
	usage

	exit 2
fi

DIR=$2

if [ -z $DIR ]; then
	DIR=$(basename $1)
fi

echo "Cloning bare repository"
git clone --bare "$1" "$DIR"

echo "Adjusting origin fetch locations..."
(cd $DIR && git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*")
echo "Success."
