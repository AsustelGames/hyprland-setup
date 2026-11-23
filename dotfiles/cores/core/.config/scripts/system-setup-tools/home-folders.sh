#!/usr/bin/env bash


mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/Documents/Projects"
mkdir -p "$HOME/Pictures/Screenshots"
mkdir -p "$HOME/Videos/OBS"

mkdir -p "$HOME/Bookmarks"

ln -s "/etc/nixos" "$HOME/Bookmarks/nixos"
ln -s "/run/media/$USER" "$HOME/Bookmarks/mnt"
ln -s "/home/asustel/.local/share/Trash/files" "$HOME/Bookmarks/trash"
