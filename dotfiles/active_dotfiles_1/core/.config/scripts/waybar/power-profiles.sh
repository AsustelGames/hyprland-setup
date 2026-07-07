#!/usr/bin/env bash


profile=$(powerprofilesctl get 2>/dev/null)


case $profile in
  performance) echo "󰈸 performance" ;;
  balanced)    echo " balanced" ;;
  power-saver) echo " power-saver" ;;
  *)           echo " error" ;;
esac
