#!/bin/bash
# This tool is used to sync remote dot file to this folder.
# Note all the dot file should both support mac and linux

HOST=$1

if [[ -z $HOST ]]; then
  echo "usage: sync.sh HOST_NAME"
fi

LINUX_CONFIG_LOCAL="$( cd "$(readlink  $( dirname "${BASH_SOURCE[0]}" ))" && pwd )"

scp -r $USER@$HOST:~/linuxConfig/* "$LINUX_CONFIG_LOCAL"
