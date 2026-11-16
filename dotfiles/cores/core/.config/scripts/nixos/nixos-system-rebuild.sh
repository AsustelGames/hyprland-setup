#!/usr/bin/env bash


host="$1"
nixosPath="/etc/nixos"
currentHostInfoFile="/nixos-config-data/host/current"
allHosts=$(ls "${nixosPath}/hosts" | sed 's/^/  /')
currentHost=""

[ -f "${currentHostInfoFile}" ] && currentHost=$(cat "${currentHostInfoFile}")

if [ -z "${host}" ]; then
  if [ -z "${currentHost}" ]; then
    echo "Error failed to detect the current host automatically"
    echo "Please specify a host, if you specify the wrong host your system can crash"
    echo ""
    echo "Available hosts:"
    echo "${allHosts}"
    echo ""
    exit
  fi
  targetHost="${currentHost}"
else
  isHostValid=$(printf "${allHosts}" | grep -w "${host}")
  if [ -z "${isHostValid}" ]; then
    echo "'${host}' is not a valid host"
    echo ""
    echo "Available hosts:"
    echo "${allHosts}"
    echo ""
    exit
  fi
  targetHost="${host}"
fi

sudo nixos-rebuild switch --flake "${nixosPath}#${targetHost}" --impure
