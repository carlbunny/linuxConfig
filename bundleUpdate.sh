for d in ~/.vim/bundle/* ; do (cd "$d" && pwd && proxycmd.sh git pull); done;
