#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

if [[ -s '/mnt/vol/engshare/admin/scripts' ]]; then
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

autoload -Uz promptinit
promptinit
prompt carlbunny

export PATH=$HOME/bin:/usr/local/bin:$PATH
