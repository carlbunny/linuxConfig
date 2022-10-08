# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

export PATH=~/bin:/usr/local/bin:$PATH

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi


# weird zsh history
alias history='history 1'

autoload -Uz promptinit
promptinit

# show non-zero return
# open ~/.p10k.zsh, set POWERLEVEL9K_STATUS_ERROR=true
prompt powerlevel10k

export EDITOR=$(which vim)
export VISUAL=$(which vim)


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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
