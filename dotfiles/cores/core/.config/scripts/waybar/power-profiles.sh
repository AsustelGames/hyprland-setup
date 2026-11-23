#!/usr/bin/env bash


profile=$(busctl --system get-property net.hadess.PowerProfiles /net/hadess/PowerProfiles net.hadess.PowerProfiles ActiveProfile | cut -d '"' -f 2)


case $profile in
  performance) echo '{"text":"󰈸 performance","class":"performance"}' ;;
  balanced)    echo '{"text":" balanced","class":"balanced"}' ;;
  power-saver) echo '{"text":" power-saver","class":"power-saver"}' ;;
  *)           echo '{"text":" error","class":""}' ;;
esac
