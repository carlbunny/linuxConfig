#!/bin/bash -vx

# will update the compile_commnds.json in the main fbcode
# Usage: # nohup ./autobear.sh &

while true; do
  TIME_TO_RUN=$(date -d "tomorrow 03:00" +%s)
  CURRENT=$(date +%s)
  
  echo "Sleep at $(date)"
  sleep $(($TIME_TO_RUN-$CURRENT))
  
  echo "Wake up at $(date)"

  cd /data/users/carlfu/fbcode
  #git checkout master
  #git pull

  #fbmake clean
  fbconfig -r cold_storage && bear -- fbmake --distcc off --ccache off opt

done
