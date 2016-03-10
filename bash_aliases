# .bashrc

alias mv='mv -i'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias df='df -h'
alias du='du -h'
alias ack='ack --color'
alias less='less -R'
alias pstree='pstree -p'
#for ycm
alias ctags='ctags --fields=+l'

### Get os name via uname ###
_myos="$(uname)"

### add alias as per os using $_myos ###
# add color option to ls
case $_myos in
   Linux) alias ls='ls --color=auto -h' ;;
   Darwin) alias ls='ls -hG' ;;
   *) ;;
esac

#for db client
db() {
  if [[ -t 1 ]]; then
    command db -u "$@" --auto_rehash
  else 
    command db "$@"
  fi
}

dbdump() {
  command db -d -r "$@"
}

fbmake() {
  if [ $# = 0 ]; then
    command fbmake dbg -j70
  else
    command fbmake $@
  fi
}

bbd() {
  command buck build @mode/dbg
}

fbconfig() {
  command fbconfig --clang $@
}
