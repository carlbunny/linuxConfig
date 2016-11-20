#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Update from github
# git pull && git submodule update --init --recursive

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

export PATH=~/bin:$PATH

zssh() ssh "$@" -t zsh

# Used for partially accept auto-suggestion
bindkey "^o" forward-word
set ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd

# Disable hostname completion, maybe it is the cause of the slowness
zstyle ':completion:*' hosts off
# Speed up the zsh completion

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Try to slove cd completion slow under git.
__git_files () {
  _wanted files expl 'local files' _files   
}

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


