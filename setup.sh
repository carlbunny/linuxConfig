#!/bin/bash
# extract the dot file in this folder to the home directory

echo "install zsh and prezto before running"

LINUX_CONFIG_LOCAL="$( cd "$(readlink  $( dirname "${BASH_SOURCE[0]}" ))" && pwd )"
ls "$LINUX_CONFIG_LOCAL" | grep -v "\.sh" | xargs -I {} ln -s {} ~/.{}

#copy the prompt 
ls "$LINUX_CONFIG_LOCAL" | grep "prompt" | xargs -I {} ln -s {} ~/.zprezto/modules/prompt/functions/
