#!/usr/bin/env bash


find "$2" -type f -name "*.tmpl" -print0 | while IFS= read -r -d '' f; do
  gomplate --plugin hex2rgb="$HOME/.config/scripts/hex-to-rgb.sh" -c root="$1" -f "$f" -o "${f%.tmpl}"
done
