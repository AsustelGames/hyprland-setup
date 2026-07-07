#!/usr/bin/env bash


dotfilesPath="/etc/nixos/dotfiles"

applyPath="$1"
rootFilePath="$2"

find "${applyPath}" -type f -name "*.tmpl" -print0 | while IFS= read -r -d '' f; do
  gomplate --plugin hex2rgb="${dotfilesPath}/cores/core/.config/scripts/gomplate/hex-to-rgb.sh" -c root="${rootFilePath}" -f "$f" -o "${f%.tmpl}"
done
