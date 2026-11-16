#!/usr/bin/env bash


nixosPath="/etc/nixos"
input="$1"
allInputs=$(nix flake metadata --no-warn-dirty --json "${nixosPath}" | jq -r '.locks.nodes.root.inputs | keys[]' | sed 's/^/  /')

if [ -z ${input} ]; then
  echo "Inputs you can update:"
  echo "${allInputs}"
  printf "\n"
else
  isValidInput=$(printf "${allInputs}" | grep -w "${input}")
  [ -z "${isValidInput}" ] && echo "'${input}' is not an valid input" && exit
  echo "Updating input '${input}'"
  sudo nix flake lock --update-input "$1" ${nixosPath}
  echo "Now rebuild the system to see changes"
fi
