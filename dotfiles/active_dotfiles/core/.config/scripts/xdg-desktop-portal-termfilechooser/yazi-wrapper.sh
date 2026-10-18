#!/usr/bin/env bash

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"
debug="$6"

notify-send "hey5"

set -e

if [ "$debug" = 1 ]; then
  set -x
fi

case "$multiple$directory$save" in
  000) mode=file ;;
  100) mode=files ;;
  010) mode=dir ;;
  001) mode=save-file ;;
  110) mode=dirs ;;
  101) mode=save-files ;;
  011) mode=save-dir ;;
  111) mode=save-dir ;;
  *) echo "invalid params" >&2; exit 1
esac

touch $out

if [ "$save" = 1 ]; then
  escaped=$(printf "%s" "$path" | sed 's/"/\\"/g')
  notify-send "1 $escaped" "$mode, $path, ${escaped%/*}, n ${escaped##*/}"
   # > export YAZI_FP_T1="Press 'enter' to confirm location" && export YAZI_FP_T2="Press 'q' to cancel" && export YAZI_FP_NAME="Saving file as: " && export YAZI_FP_FILENAME="tnt.png" && y
  # export YAZI_FP_T1="Press 'enter' to confirm location"
  # export YAZI_FP_T2="Press 'q' to cancel"
  # export YAZI_FP_NAME="Saving file as: "
  # export YAZI_FP_FILENAME="${path##*/}"
  # selectedFiles=$(mktemp)
  # kitty --class floating-program-yazi-filepicker yazi --chooser-file="$selectedFiles"
  # notify-send "1 $escaped" "$mode, $path, ${escaped%/*}, n ${escaped##*/}"
  # if [ -n ${selectedFiles} ]; then
  #   touch "${selectedFiles%/*}/${escaped%/*}"
  #   notify-send "2 ${selectedFiles}" "${selectedFiles%/*}/${escaped%/*}"
  # fi
  # notify-send "2 ${selectedFiles}" "${selectedFiles%/*}/${escaped%/*}"
  # rm -f "${selectedFiles}"
  kitty --class filechooser kitty +kitten choose-files --mode=$mode --write-output-to "$out" --suggested-save-file-name "\"$escaped\""
else
  # kitty --class floating-program-yazi-filepicker yazi
  kitty --class filechooser kitty +kitten choose-files --mode=$mode --write-output-to "$out"
fi
