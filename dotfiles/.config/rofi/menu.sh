#!/bin/bash

programTheme="-theme $HOME/.config/rofi/themes/programs.rasi"
powerTheme="-theme $HOME/.config/rofi/themes/power.rasi"
clipboardTheme="-theme $HOME/.config/rofi/themes/clipboard.rasi"

selfPath="$HOME/.config/rofi/menu.sh"
screenshotPath="$HOME/Photos/Screenshots"

terminal="kitty"

flag=$1


if [ -z "$flag"  ]; then # Screenshot Menu
  options=(
    " Screenshot Window"
    " Screenshot Area"
    "󰍹 Screenshot Monitor"
    "󰌁 ColorPicker"
  )

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Search: " $programTheme)

  case "$choice" in
    0) exec hyprshot -m window -o $screenshotPath & ;;
    1) exec hyprshot -m region -o $screenshotPath & ;;
    2) exec hyprshot -m output -o $screenshotPath & ;;
    3) exec hyprpicker -a | wl-copy & ;;
    #"") exec  & ;;
  esac

elif [ "$flag" = "-p" ]; then # Power Menu
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

elif [ "$flag" = "-c" ]; then # Clipboard Menu
  cliphist list | rofi -dmenu -p "Search: " $clipboardTheme -display-columns 2 | cliphist decode | wl-copy

elif [ "$flag" = "-w" ]; then # Clipboard Menu
  cliphist wipe && cliphist list | rofi -dmenu -p "> Wiped: " $clipboardTheme -display-columns 2 | cliphist decode | wl-copy

elif [ "$flag" = "-a" ]; then # App Menu
  rofi -show drun -display-drun "Search: " $programTheme

else # Error
  rofi -show drun -display-drun "> Error $flag: " $programTheme
fi
