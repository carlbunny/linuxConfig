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

alias fbgcc='/usr/local/fbcode/gcc-5-glibc-2.23/bin/g++'
alias g++='/usr/local/fbcode/gcc-5-glibc-2.23/bin/g++'

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

# for ycm completion
function gen_cdb() {
  FBCODE=$(pwd | grep -o ".*/fbcode[^/]*/")
  echo "Run in $FBCODE"
  cd "$FBCODE"
  COMMAND="./tools/codegraph/buck_compilation_databases -o ./buck-out/list.json --transitive "
  for var in "$@"
  do
    COMMAND+="--buck-target //$var "
  done
  eval "$COMMAND"
  eval jq -s add `jq ".[]" ./buck-out/list.json | tr '\n' ' '` | jq 'del(.[].arguments)' >! \
    compile_commands.json
  echo All Done
  ls -lah compile_commands.json
}
