#!/bin/sh

flag=$1
flag2=$2

mkdir -p /tmp/kitty-sockets
socketPath="/tmp/kitty-sockets/$(uuidgen).sock"

pid=$(fuser "$socketPath" 2>/dev/null | awk '{print $NF}')

if [ "$flag" != "-r" ]; then
  kitty --listen-on="unix:$socketPath" "${@:1}" & 

  sleep 0.5
  
  echo $socketPath
else
  sleep 0.1

  for sock in /tmp/kitty-sockets/*.sock; do
    [ -S "$sock" ] || continue

    pid=$(fuser "$sock" 2>/dev/null | awk '{print $NF}')
    
	 echo $pid
    kill -SIGUSR1 "$pid"
  done
fi
