#!/usr/bin/env bash


kittySocketDir="$XDG_RUNTIME_DIR/kitty-sockets"
mkdir -p "${kittySocketDir}"
kittySocketPath="${kittySocketDir}/$(uuidgen).sock"
nvimSocketDir="$XDG_RUNTIME_DIR/nvim-sockets"


if [ "$1" != "-r" ]; then
  kitty --listen-on="unix:$kittySocketPath" "${@:1}" &
else
  sleep 0.1

  for sock in "${kittySocketDir}"/*.sock; do
    [ -S "${sock}" ] || continue

    pid=$(fuser "${sock}" 2>/dev/null | awk '{print $NF}')
    
    kill -SIGUSR1 "${pid}" # Don't worry the error it returns is harmless
  done
  
  for sock in "${nvimSocketDir}"/*.sock; do
    [ -S "${sock}" ] || continue
    
    nvim --server "${sock}" --remote-expr 'execute("luafile ~/.config/nvim/lua/colors.lua")' &
    nvim --server "${sock}" --remote-expr 'execute(":lua reloadTheme()")' &
  done
fi
