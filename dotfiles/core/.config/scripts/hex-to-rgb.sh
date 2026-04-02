#!/usr/bin/env bash


hex_to_rgb() {
  local hex="$1"

  hex="${hex#"#"}"

  if [[ ! "$hex" =~ ^[0-9A-Fa-f]{6}$ ]]; then
    echo -e "\e[31mError: Invalid hex color. Use format #RRGGBB or RRGGBB.\e[0m"
    return 1
  fi

  local r=$((16#${hex:0:2}))
  local g=$((16#${hex:2:2}))
  local b=$((16#${hex:4:2}))

  echo "$r, $g, $b"
}

hex_to_rgb "$1"
