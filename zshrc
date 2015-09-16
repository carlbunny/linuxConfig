#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
source $HOME/.zprezto/runcoms/zshrc

# Customize to your needs...
if [[ -s '/mnt/vol/engshare/admin/scripts' ]]; then
  # On devserver
  [[ -z "$ADMIN_SCRIPTS" ]] && export ADMIN_SCRIPTS='/mnt/vol/engshare/admin/scripts'
  source "${ADMIN_SCRIPTS}/master.zshrc"

  source "${ADMIN_SCRIPTS}/scm-prompt"
else
  source "~/scm-prompt"
fi

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# weird zsh history
alias history='history 1'

autoload -Uz promptinit
promptinit
prompt carlbunny
#prompt peepcode

export EDITOR=$(which vim)
export VISUAL=$(which vim)

export PATH=$PATH:~/bin

zssh() ssh "$@" -t zsh

#key binding
#bindkey '"\C-p": shell-backward-kill-word'

# Instead of
# INC_APPEND_HISTORY,
# this will let history go to share after the succession exist.
#setopt APPEND_HISTORY
HISTSIZE=130000 SAVEHIST=130000

#run tmux on login
if [[ -z "$TMUX" ]] && [[ "$_myos" = "Linux" ]] ;then
  ID=$(tmux ls | grep -vm1 attached | cut -d: -f1) # get the id of a deattached session
  if [[ -z "$ID" ]] ;then # if not available create a new one
      tmux new-session 
  else
      tmux attach -d -t "$ID" # if available attach to it
  fi
fi


