# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source Facebook definitions
if [ -f /mnt/vol/engshare/admin/scripts/master.bashrc ]; then
	. /mnt/vol/engshare/admin/scripts/master.bashrc
fi

#PS1='[\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\]]\[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

alias mv='mv -i'

export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTFILESIZE=1000000
shopt -s histappend
shopt -s histverify


alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias gdb='cgdb'
alias ack='ack --color'

# Bash completion
if [ -f /etc/bash_completion.d ]; then
  . /etc/bash_completion.d
fi
export PS1='[\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\]] '
export GIT_PS1_SHOWDIRTYSTATE=1



export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64
