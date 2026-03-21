#!/bin/bash

themesPath="$HOME/.config/rofi/themes"
programTheme="${themesPath}/programs.rasi"
powerTheme="${themesPath}/power.rasi"
clipboardTheme="${themesPath}/clipboard.rasi"
currentTheme=""

screenshotPath="$HOME/Photos/Screenshots"
dotfilesPath="/etc/nixos/dotfiles"

kittyScriptPath="$HOME/.config/scripts/kitty.sh"

flag=$1


menu() {
  if [ -e "$programTheme" ]; then
    currentTheme="-theme $programTheme"
  fi
  options=(
    "󰃠 Brightness"
    " Screenshot + Colorpicker"
    " Screenshot to clipboard + Colorpicker"
    " Apps"
    " Clipboard"
    " Wipe Clipboard"
    "󰈈 Select Theme"
    "⏻ Power Options"
  )
  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Menu: " $currentTheme)
  case "$choice" in
    0) brightnessMenu ;;
    1) screenshotMenu ;;
    2) screenshotMenu --alt ;;
    3) appMenu ;;
    4) clipboardMenu ;;
    5) clipboardWipe ;;
    6) themeMenu ;;
    7) powerMenu ;;
  esac
}


brightnessMenu() {
  if [ -e "$clipboardTheme" ]; then
    currentTheme="-theme $clipboardTheme"
  fi
  
  if [ "$1" = "" ]; then
    device=$(brightnessctl -l | awk -F"'" '/Device/ {print $2}' | rofi -dmenu -p "Devices with brightness: " $currentTheme)
  fi
  
  if [ "$device" == "" ]; then
    exit
  fi

  brightnessPercent=$(brightnessctl -d $device -m | cut -d, -f4)
  
  options=(
    " +10% Brightness (current ${brightnessPercent})"
    " -10% Brightness (minimum 10%)"
  )
  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Change brightness of ${device}: " $currentTheme)

  if [ "$choice" == "" ]; then
    exit
  fi

  case "$choice" in
    0) brightnessctl -d $device s +10% ;;
    1) if [ "${brightnessPercent%\%}" -gt 10 ]; then brightnessctl -d $device s 10%-; fi ;;
  esac

  brightnessMenu $device
}


screenshotMenu() {
  if [ -e "$programTheme" ]; then
    currentTheme="-theme $programTheme"
  fi

  if [ "$1" = "--alt" ]; then
    extraCommand="--clipboard-only"
    extraTitle=" to Clipboard"
  fi
  
  options=(
    " Screenshot Area"
    " Screenshot Window"
    "󰍹 Screenshot Monitor"
  )

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Screenshot${extraTitle}: " $currentTheme)

  case "$choice" in
    0) exec hyprshot -m region -o $screenshotPath $extraCommand & ;;
    1) exec hyprshot -m window -o $screenshotPath $extraCommand & ;;
    2) exec hyprshot -m output -o $screenshotPath $extraCommand & ;;
    3) exec hyprpicker -a | wl-copy & ;;
  esac
}


appMenu() {
  if [ -e "$programTheme" ]; then
    currentTheme="-theme $programTheme"
  fi
  rofi -show drun -display-drun "Apps: " $currentTheme
}


clipboardMenu() {
  if [ -e "$programTheme" ]; then
    currentTheme="-theme $programTheme"
  fi

  if [ "$1" = "--alt" ]; then
    cliphist wipe
  fi
  
  cliphist list | rofi -dmenu -p "Clipboard: " $currentTheme -display-columns 2 | cliphist decode | wl-copy
}


themeMenu() {
  if [ -e "$programTheme" ]; then
    currentTheme="-theme $programTheme"
  fi
  options=(
    "󰈈 Themes"
    "󰗉 Waybar Themes"
  )

  themeType=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Theme: " $currentTheme)

  case "$themeType" in
    0) themeType="main" ;;
    1) themeType="waybar" ;;
  esac
  
  
  if [ "$themeType" == "" ]; then
    exit
  fi
  
  choice=$(ls "${dotfilesPath}/themes/${themeType}" | rofi -dmenu -p "Theme: " $currentTheme)

  if [ -z "${choice}" ]; then
    exit
  fi
  
  themeFiles=("${dotfilesPath}/themes/${themeType}")
  
  if [ "$themeType" == "main" ]; then
    for i in "${!themeFiles[@]}"; do
      stow -t $HOME -d ${dotfilesPath}/themes/${themeType} -D "$(basename "${themeFiles[$i]}")"
    done
    pkill waybar
    pkill hyprpaper
    stow -t $HOME -d ${dotfilesPath} -D core
    rm -r ${dotfilesPath}/current_theme
    
    stow -t $HOME -d ${dotfilesPath} core
    cp -r "${dotfilesPath}/themes/${themeType}/${choice}" ${dotfilesPath}/current_theme
    stow -t  $HOME -d ${dotfilesPath} current_theme
    
    hyprctl reload
    waybar &
	 bash "$kittyScriptPath" -r &
    hyprpaper &

    echo "${choice}" > ${dotfilesPath}/current_theme/current_theme.info
  else
    for i in "${!themeFiles[@]}"; do
      stow -t $HOME -d ${dotfilesPath}/themes/${themeType} -D "$(basename "${themeFiles[$i]}")"
    done
    pkill waybar
    rm -r ${dotfilesPath}/current_waybar_theme
    
    
    cp -r "${dotfilesPath}/themes/${themeType}/${choice}" ${dotfilesPath}/current_waybar_theme
    stow -t $HOME -d ${dotfilesPath} current_waybar_theme
    
    waybar &
  fi
}


powerMenu() {
  if [ -e "$powerTheme" ]; then
    currentTheme="-theme $powerTheme"
  fi
  options=(
    "󰐥 Shutdown"
    " Reboot"
    "󰍃 Logout"
  )
  confirmationOptions=(" No" " Yes")

  choice=$(printf "%b\n" "${options[@]}" | rofi -dmenu -format i -p "Power: " $currentTheme)
  [ -z "$choice" ] && exit

  confirmation=$(printf "%s\n" "${confirmationOptions[@]}" | rofi -dmenu -p "$choice?: " $currentTheme)

  if [[ "$confirmation" == " Yes" ]]; then
    case "$choice" in
      0) poweroff ;;
      1) reboot ;;
      2) hyprctl dispatch exit ;;
    esac
  fi
}



case "$flag" in
  "" ) menu ;;
  -b ) brightnessMenu ;;
  -s ) screenshotMenu ;;
  -S ) screenshotMenu --alt ;;
  -a ) appMenu ;;
  -c ) clipboardMenu ;;
  -w ) clipboardMenu --alt ;;
  -t ) themeMenu ;;
  -p ) powerMenu ;;
  *  ) menu ;;
esac
