#!/usr/bin/env bash


dotfilePath="/etc/nixos/dotfiles"
scriptDir="${dotfilePath}/cores/core/.config/scripts"

chmod u+x "${scriptDir}/menu.sh"

chmod u+x "${scriptDir}/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh"

chmod u+x "${scriptDir}/waybar/cava.sh"
chmod u+x "${scriptDir}/gomplate/hex-to-rgb.sh"

chmod u+x "${scriptDir}/cli-utils/nixos-system-rebuild.sh"
chmod u+x "${scriptDir}/cli-utils/nixos-system-update.sh"
chmod u+x "${scriptDir}/cli-utils/autoedit.sh"

chmod u+x "${scriptDir}/system-setup-tools/app-hider.sh"
chmod u+x "${scriptDir}/system-setup-tools/home-folders.sh"
