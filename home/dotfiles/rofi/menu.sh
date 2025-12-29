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

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -show-icons -p "Search: " $programTheme)

  case "$choice" in
    " Audio") exec hyprctl dispatch exec '[float]' kitty wiremix & ;;
    "󰖩 Internet") exec hyprctl dispatch exec '[float]' kitty nmtui & ;;
    "󰂯 Bluetooth") exec hyprctl dispatch exec '[float]' kitty bluetui & ;;
    " Apps") . $selfPath -a & ;;
    "󱃷 All Apps") . $selfPath -A & ;;
    " Clipboard") exec cliphist list | rofi -dmenu -p "Search: " $clipboardTheme -display-columns 2 | cliphist decode | wl-copy & ;;
    " Screenshot") exec hyprshot -m region -o $screenshotPath & ;;
    " Colorpicker") exec hyprpicker -a | wl-copy & ;;
    "⏻ Power") . $selfPath -p & ;;
    #"") exec  & ;;
  esac
elif [ "$flag" = "-p" ]; then
  options=()
  options[1]="󰐥 Shutdown"
  options[2]=" Reboot"
  options[3]="󰍃 Logout"

  confirmationOptions=(" No" " Yes")

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -p "Search: " $powerTheme)
  [ -z "$choice" ] && exit

  confirmation=$(printf "%s\n" "${confirmationOptions[@]}" | rofi -dmenu -p "$choice?: " $powerTheme)

  if [[ "$confirmation" == " Yes" ]]; then
    case "$choice" in
      "󰐥 Shutdown") poweroff ;;
      " Reboot") reboot ;;
      "󰍃 Logout") hyprctl dispatch exit ;;
    esac
  fi
elif [ "$flag" = "-c" ]; then
  cliphist list | rofi -dmenu -p "Search: " $clipboardTheme -display-columns 2 | cliphist decode | wl-copy
elif [ "$flag" = "-a" ]; then
   options=(
    " Neovim"
    " Steam"
    " Prism Launcher"
    "󰡔 Bottles"
    " Discord"
    " Btop"
    " MPV"
    "󰄛 Kitty"
    " Brave"
    "󰇥 Yazi"
  )

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -show-icons -p "Search: " $programTheme)

  case "$choice" in
    " Neovim") exec $terminal nvim & ;;
    " Steam") $coolerWarning && $runOnGPUCommand steam & ;;
    " Prism Launcher") $coolerWarning && $runOnGPUCommand prismlauncher & ;;
    "󰡔 Bottles") $coolerWarning && $runOnGPUCommand bottles & ;;
    " Discord") exec discord & ;;
    " Btop") exec $terminal btop & ;;
    " MPV") exec $terminal mpv & ;;
    "󰄛 Kitty") exec $terminal & ;;
    " Brave") exec brave & ;;
    "󰇥 Yazi") exec $terminal yazi & ;;
    #"") exec  & ;;
  esac
else
  rofi -show drun -display-drun "Search: " $programTheme
fi
