#!/usr/bin/env bash


profile=$(powerprofilesctl get 2>/dev/null)


case $profile in
  performance) echo '{"text":"󰈸 performance","class":"performance"}' ;;
  balanced)    echo '{"text":" balanced","class":"balanced"}' ;;
  power-saver) echo '{"text":" power-saver","class":"power-saver"}' ;;
  *)           echo '{"text":" error","class":""}' ;;
esac
