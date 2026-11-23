#!/usr/bin/env bash


file="$1"

if [ -w "${file}" ]; then
  $EDITOR "${file}"
elif [[ ! -w "${file}" && -n ${file} ]]; then
  sudoedit "${file}"
else
  $EDITOR
fi
