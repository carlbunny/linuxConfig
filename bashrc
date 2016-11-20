# .bashrc

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source Facebook definitions
if [ -f /mnt/vol/engshare/admin/scripts/master.bashrc ]; then
	. /mnt/vol/engshare/admin/scripts/master.bashrc
fi

#PS1='[\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\]]\[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'


export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTFILESIZE=1000000
shopt -s histappend
shopt -s histverify
# show history of all terminal
export PROMPT_COMMAND='history -a; history -r'


# Bash completion
if [ -f /etc/bash_completion.d ]; then
  . /etc/bash_completion.d
fi

export PS1='[\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\]] '
export GIT_PS1_SHOWDIRTYSTATE=1

# enable something like ctrl+s work in vim
stty -ixon


export PATH=/usr/local/bin:$PATH:/usr/local/fbcode/gcc-4.9-glibc-2.20-fb/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64
export JAVA_HOME=/usr/local/jdk-6u29-64/
