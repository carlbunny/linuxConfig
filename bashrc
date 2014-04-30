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


alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'
alias grep='grep --color=always'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=always'
alias gdb='cgdb'
alias ack='ack --color'
alias less='less -R'
#for ycm
alias ctags='ctags --fields=+l'


# Bash completion
if [ -f /etc/bash_completion.d ]; then
  . /etc/bash_completion.d
fi
export PS1='[\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\]] '
export GIT_PS1_SHOWDIRTYSTATE=1

# enable something like ctrl+s work in vim
stty -ixon


export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64
export JAVA_HOME=/usr/local/jdk-6u29-64/
