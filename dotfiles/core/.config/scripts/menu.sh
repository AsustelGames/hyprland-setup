#!/usr/bin/env bash


themesPath="$HOME/.config/rofi/themes"
programTheme="${themesPath}/programs.rasi"
powerTheme="${themesPath}/power.rasi"
clipboardTheme="${themesPath}/clipboard.rasi"
currentTheme=""

screenshotPath="$HOME/Photos/Screenshots"
dotfilesPath="/etc/nixos/dotfiles"

kittyScriptPath="$HOME/.config/scripts/kitty.sh"

flag=$1


openMenu() {
  #openMenu "i/-" "dmenu/drun/e" "title" "message" "2/-"
  if [ "$1" = "i" ]; then
    returnType="-format i"
  fi

  if [ "$2" = "dmenu" ]; then
    menuType="-dmenu"
  elif [ "$2" = "e" ]; then
    menuType="-e"
  else
    menuType="-show drun"
  fi

  if [ "$4" != "" ]; then
    message="-mesg"
  fi


  if [ "$5" = "2" ]; then
    displayType="-display-columns 2"
  fi

  rofi -i $returnType $menuType -p "$3" -display-drun "$3" $message "$4" $displayType $currentTheme
}

menu() {
  if [ -e "$programTheme" ]; then
    currentTheme="-theme $programTheme"
  fi
  options=(
    "󰃠 Brightness"
    " Power Profiles"
    " Screenshot + Colorpicker"
    " Screenshot to clipboard + Colorpicker"
    " Apps"
    " Clipboard"
    " Wipe Clipboard"
    "󰈈 Manage Themes & Dotfiles"
    "⏻ Power Options"
    " Help"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "dmenu" "Menu: " "" "")

  case "$choice" in
    0) brightnessMenu ;;
    1) powerProfilesMenu ;;
    2) screenshotMenu ;;
    3) screenshotMenu --alt ;;
    4) appMenu ;;
    5) clipboardMenu ;;
    6) clipboardWipe ;;
    7) themeMenu ;;
    8) powerMenu ;;
  esac
}


brightnessMenu() {
  if [ -e "$clipboardTheme" ]; then
    currentTheme="-theme $clipboardTheme"
  fi
  
  if [ "$1" = "" ]; then
    device=$(brightnessctl -l | awk -F"'" '/Device/ {print $2}' | openMenu "" "dmenu" "Devices with brightness: " "" "")
  fi
  
  if [ "$device" == "" ]; then
    exit
  fi

  brightnessPercent=$(brightnessctl -d $device -m | cut -d, -f4)
  
  options=(
    " +10% Brightness (current ${brightnessPercent})"
    " -10% Brightness (minimum 10%)"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "dmenu" "Change brightness of "${device}": " "" "")

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
    extraTitle="Screenshot to Clipboard"
  fi
  
  options=(
    " Screenshot Area"
    " Screenshot Window"
    "󰍹 Screenshot Monitor"
    "󰌁 Colorpicker"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "dmenu" "Screenshot: " "${extraTitle}" "")

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

  openMenu "" "drun" "Apps: " "" ""
}


clipboardMenu() {
  if [ -e "$clipboardTheme" ]; then
    currentTheme="-theme $clipboardTheme"
  fi

  if [ "$1" = "--alt" ]; then
    cliphist wipe
  fi
  
  cliphist list | openMenu "" "dmenu" "Clipboard: " "" "2" | cliphist decode | wl-copy
}


themeMenu() {
  echo "Running themeMenu"
  if [ -e "$programTheme" ]; then
    currentTheme="-theme $programTheme"
  fi
  options=(
    "󰈈 Set Theme"
    "󰗉 Set Waybar Theme"
    " Select Core"
    " Initialize Theme & Core"
    " Remove All Active Cores/Themes & Dotfiles"
    " Help"
  )
  themeType=$(printf "%b\n" "${options[@]}" | openMenu "i" "dmenu" "Themes & Dotfiles: " "" "")

  case "$themeType" in
    0) themeType="main" ;;
    1) themeType="waybar" ;;
    2) themeType="core" ;;
    3) themeType="init" ;;
    4) themeType="remove" ;;
    5) themeType="help" ;;
  esac
  
  
  if [ "$themeType" == "" ]; then
    exit
  fi
  
  if [ "$themeType" != "" ]; then
    choice=$(ls "${dotfilesPath}/themes/${themeType}" | openMenu "" "dmenu" "Themes: " "" "")
    
    if [ -z "$choice" ]; then
      exit
    fi
  fi


  count=$(find ${dotfilesPath}/cores -mindepth 1 -maxdepth 1 -type d | wc -l)

  if [ "$count" -gt 1 ]; then
    echo "More than one directory in cores"
  fi

  echo "$themeType"

  themeChoicePath="${dotfilesPath}/themes/${themeType}/${choice}"
  activeDotfilesPath="${dotfilesPath}/active_dotfiles"
  mkdir -p "${dotfilesPath}/active_dotfiles" 
  
  if [ "$themeType" = "main" ]; then
    # Remove and unstow previous theme
	 stow -t $HOME -d "${activeDotfilesPath}" -D "main_theme"
    stow -t $HOME -d "${activeDotfilesPath}" -D "core"
    rm -r "${activeDotfilesPath}/main_theme"
    rm -r "${activeDotfilesPath}/core"

    cp -r "${themeChoicePath}" ${activeDotfilesPath}/main_theme
	 cp -r "${dotfilesPath}/core" "${activeDotfilesPath}/core"
    stow -t  $HOME -d "${activeDotfilesPath}" "main_theme"
    stow -t $HOME -d "${activeDotfilesPath}" "core"
 
    pkill waybar
	 swww-daemon --no-cache &
	 swww img --resize crop -t grow --transition-fps 120 "$HOME/.config/bg.jpg" &
	 waybar &
    bash "$kittyScriptPath" -r &
    hyprctl reload
	 swaync-client -R

    #echo "${choice}" > ${dotfilesPath}/current_theme/current_theme.info
  elif [ "$themeType" = "waybar" ]; then
    stow -t $HOME -d "${activeDotfilesPath}" -D "waybar_theme"
    rm -r "${activeDotfilesPath}/waybar_theme"

    cp -r "${themeChoicePath}" "${activeDotfilesPath}/waybar_theme"
    stow -t $HOME -d "${activeDotfilesPath}" "waybar_theme"

    pkill waybar
    waybar &
  elif [ "$themeType" = "core" ]; then
    echo "1"
  elif [ "$themeType" = "init" ]; then
    echo "2"
  elif [ "$themeType" = "remove" ]; then
    echo "3"
  elif [ "$themeType" = "help" ]; then
    echo "4"
  fi
}


powerMenu() {
  if [ -e "$powerTheme" ]; then
    currentTheme="-theme $powerTheme"
  fi
  options=(
    "󰌾 Lock"
	 "󰤄 Hibernate (todo)"
    "󰐥 Shutdown"
    " Reboot"
    "󰍃 Logout"
  )
  confirmationOptions=(" No" " Yes")
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "dmenu" "Screenshot: " "" "")

  if [ "$choice" = "" ]; then
    exit
  fi
  
  if [ "$choice" != "0" ]; then
    confirmation=$(printf "%b\n" "${confirmationOptions[@]}" | openMenu "i" "dmenu" "$choice?: " "${extraTitle}" "")
  fi

  
  if [ "$confirmation" = "0" ]; then
    exit
  fi

  case "$choice" in
    0) echo "bruh" ;;
	 1) echo "magic" ;;
    2) poweroff ;;
    3) reboot ;;
    4) hyprctl dispatch exit ;;
  esac
}


powerProfilesMenu() {
  if [ -e "$programTheme" ]; then
    currentTheme="-theme $programTheme"
  fi
  
  options=(
    "󰈸 Performance" 
    " Balanced"
    " Power Saver"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "dmenu" "Set Power Profile: " "" "")

  if [ "$choice" == "" ]; then
    exit
  fi

  case "$choice" in
    0) powerprofilesctl set performance ;;
    1) powerprofilesctl set balanced ;;
    2) powerprofilesctl set power-saver ;;
  esac
}



case "$flag" in
  "") menu ;;
  -b) brightnessMenu ;;
  -s) screenshotMenu ;;
  -S) screenshotMenu --alt ;;
  -a) appMenu ;;
  -c) clipboardMenu ;;
  -w) clipboardMenu --alt ;;
  -t) themeMenu ;;
  -p) powerMenu ;;
  -P) powerProfilesMenu ;;
  * ) menu ;;
esac
