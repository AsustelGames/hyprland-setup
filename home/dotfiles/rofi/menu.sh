#!/bin/bash

programTheme="-theme $HOME/.config/rofi/themes/programs.rasi"
powerTheme="-theme $HOME/.config/rofi/themes/power.rasi"
clipboardTheme="-theme $HOME/.config/rofi/themes/clipboard.rasi"

selfPath="$HOME/.config/rofi/menu.sh"
screenshotPath="$HOME/screenshots"

runOnGPUCommand="nvidia-offload"
terminal="kitty"
coolerWarning="$terminal --hold echo Turn on the cooler"


flag=$1

if [ -z "$flag"  ]; then
  options=(
    " Audio"
    "󰖩 Internet"
    "󰂯 Bluetooth"
    " Apps"
    "󱃷 All Apps"
    " Clipboard"
    " Screenshot"
    " Colorpicker"
    "⏻ Power"
  )

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Search: " $programTheme)

  case "$choice" in
    0) exec hyprctl dispatch exec '[float]' kitty wiremix & ;;
    1) exec hyprctl dispatch exec '[float]' kitty nmtui & ;;
    2) exec hyprctl dispatch exec '[float]' kitty bluetui & ;;
    3) . $selfPath -a & ;;
    4) . $selfPath -A & ;;
    5) . $selfPath -c & ;;
    6) exec hyprshot -m region -o $screenshotPath & ;;
    7) exec hyprpicker -a | wl-copy & ;;
    8) . $selfPath -p & ;;
    #"") exec  & ;;
  esac
elif [ "$flag" = "-p" ]; then
  options=(
    "󰐥 Shutdown"
    " Reboot"
    "󰍃 Logout"
  )
  confirmationOptions=(" No" " Yes")

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Search: " $powerTheme)
  [ -z "$choice" ] && exit

  confirmation=$(printf "%s\n" "${confirmationOptions[@]}" | rofi -dmenu -p "$choice?: " $powerTheme)

  if [[ "$confirmation" == " Yes" ]]; then
    case "$choice" in
      0) poweroff ;;
      1) reboot ;;
      2) hyprctl dispatch exit ;;
    esac
  fi
elif [ "$flag" = "-c" ]; then
  cliphist list | rofi -dmenu -p "Search: " $clipboardTheme -display-columns 2 | cliphist decode | wl-copy
elif [ "$flag" = "-a" ]; then
   options=(
    " VSCode"
    " Steam"
    " Prism Launcher"
    "󰡔 Bottles"
    "󱗞 Ferdium"
    " OBS Studio"
    " Audacity"
    " Brave"
  )

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Search: " $programTheme)

  case "$choice" in
    0) exec code ;;
    1) $runOnGPUCommand steam & ;;
    2) $runOnGPUCommand prismlauncher & ;;
    3) $runOnGPUCommand bottles & ;;
    4) exec ferdium & ;;
    5) exec obs & ;;
    6) exec audacity & ;;
    7) exec brave & ;;
    #) exec  & ;;
  esac
else
  rofi -show drun -display-drun "Search: " $programTheme
fi
