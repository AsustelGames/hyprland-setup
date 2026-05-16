#!/usr/bin/env bash


themesPath="$HOME/.config/rofi/themes"
appsTheme="${themesPath}/apps.rasi"
powerTheme="${themesPath}/power.rasi"
clipboardTheme="${themesPath}/clipboard.rasi"
confirmationTheme="${themesPath}/confirmation.rasi"
currentTheme=""

screenshotPath="$HOME/Pictures/Screenshots"
dotfilesPath="/etc/nixos/dotfiles"
wallpaperPath="$HOME/.config/bg.jpg"

kittyScriptPath="$HOME/.config/scripts/kitty.sh"

flag=$1


openMenu() {
  #openMenu "i/-" "dmenu/drun/icons/e" "title" "message" "2/-" "no-mkr/-" "whatever else"
  if [ "$1" = "i" ]; then # Return int
    returnType="-format i"
  fi

  if [ "$2" = "drun" ]; then
    menuType="-show drun"
  elif [ "$2" = "e" ]; then
    menuType="-e"
  elif [ "$2" = "icons" ]; then
    menuType="-show drun -show-icons"
  else
    menuType="-dmenu"
  fi

  if [ "$4" != "" ]; then
    message="-mesg"
  fi


  if [ "$5" = "2" ]; then
    displayType="-display-columns 2"
  fi

  if [ "$6" = "mkr" ]; then
    markupRows="-markup-rows"
  else
    markupRows=""
  fi

  rofi -i $returnType $menuType -p "$3" -display-drun "$3" $message "$4" $displayType $currentTheme $markupRows -scroll-method 1 "$7" "$8"
  echo "rofi -i ${returnType} ${menuType} -p $3 -display-drun $3 ${message} $4 ${displayType} ${currentTheme}" ${markupRows} -scroll-method 1 "$7" "$8" >&2
}

menu() {
  requestedTheme="${appsTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi

  if [ -n "$1" ]; then
    errorMessage="Error: $0 '$1' is not an option"
  fi

  options=(
    "󰃠 Brightness"
    " Power Profiles"
    " Screenshot + Colorpicker"
    " Apps"
    " Clipboard"
    " Wipe Clipboard"
    "󰈈 Manage Themes & Dotfiles"
    "⏻ Power Options"
    " Help"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "" "${errorMessage}" "" "")

  case "$choice" in
    0) brightnessMenu ;;
    1) powerProfilesMenu ;;
    2) screenshotMenu ;;
    3) appMenu ;;
    4) clipboardMenu ;;
    5) clipboardMenu --alt ;;
    6) themeMenu ;;
    7) powerMenu ;;
  esac
}


brightnessMenu() {
  requestedTheme="${clipboardTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi
  
  if [ "$1" = "" ]; then
    device=$(brightnessctl -l | awk -F"'" '/Device/ {print $2}' | openMenu "" "" "" "Devices with changable brightness" "" "")
  fi

  if [ "${device}" == "" ]; then
    exit
  fi

  brightnessPercent=$(brightnessctl -d $device -m | cut -d, -f4)
  
  options=(
    " +10% Brightness (current ${brightnessPercent})"
    " -10% Brightness (minimum 10%)"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "" "${device}" "" "" "")

  if [ "${choice}" == "" ]; then
    exit
  fi

  case "${choice}" in
    0) brightnessctl -d $device s +10% ;;
    1) if [ "${brightnessPercent%\%}" -gt 10 ]; then brightnessctl -d $device s 10%-; fi ;;
  esac

  brightnessMenu $device
}


screenshotMenu() {
  requestedTheme="${powerTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi

  options=(
    " Screenshot Area"
    " Screenshot Window"
    "󰍹 Screenshot Monitor"
    "󰌁 Colorpicker"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "Screenshot: " "" "" "" "")

  case "${choice}" in
    0) exec hyprshot -m region -o $screenshotPath & ;;
    1) exec hyprshot -m window -o $screenshotPath & ;;
    2) exec hyprshot -m output -o $screenshotPath & ;;
    3) exec hyprpicker -a | wl-copy & ;;
  esac
}


appMenu() {
  requestedTheme="${appsTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi

  openMenu "" "icons" "Apps: " "" "" ""
}


clipboardMenu() {
  confirmationOptions=(" No" " Yes")

  if [ "$1" = "--alt" ]; then
    requestedTheme="${confirmationTheme}"
    if [ -e "${requestedTheme}" ]; then
      currentTheme="-theme ${requestedTheme}"
    fi
    confirmation=$(printf "%b\n" "${confirmationOptions[@]}" | openMenu "i" "" "" "Wipe clipboard?" "" "")

  
    if [[ "${confirmation}" = "0" || "${confirmation}" = "" ]]; then
      exit
    fi
    cliphist wipe
  fi
  
  requestedTheme="${appsTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi

  cliphist list | openMenu "" "" "Clipboard: " "" "2" "" "-theme-str" "window { width: 40%; }" | cliphist decode | wl-copy
}


themeMenu() {
  echo "Running themeMenu"
  requestedTheme="${appsTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi
  options=(
    "󰈈 Set Theme"
    "󰗉 Set Waybar Theme"
    " Select Core"
    " Initialize Theme & Core"
    " Remove All Active Cores/Themes & Dotfiles"
    " Help"
  )
  themeType=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "Themes & Dotfiles: " "" "" "")

  case "${themeType}" in
    0) themeType="main" ;;
    1) themeType="waybar" ;;
    2) themeType="core" ;;
    3) themeType="init" ;;
    4) themeType="remove" ;;
    5) themeType="help" ;;
  esac
  
  if [ "${themeType}" != "" ]; then
    choice=$(ls "${dotfilesPath}/themes/${themeType}" | openMenu "" "" "Themes: " "" "" "")
  fi
    
  if [ -z "${choice}" ]; then
    exit
  fi


  count=$(find ${dotfilesPath}/cores -mindepth 1 -maxdepth 1 -type d | wc -l)

  if [ "${count}" -gt 1 ]; then
    echo "More than one directory in cores"
  fi

  echo "${themeType}"

  themeChoicePath="${dotfilesPath}/themes/${themeType}/${choice}"
  activeDotfilesPath="${dotfilesPath}/active_dotfiles"
  mkdir -p "${dotfilesPath}/active_dotfiles" 
  
  if [ "${themeType}" = "main" ]; then
    # Remove and unstow the previous theme
    stow -t $HOME -d "${activeDotfilesPath}" -D "main_theme"
    stow -t $HOME -d "${activeDotfilesPath}" -D "core"
    rm -r "${activeDotfilesPath}/main_theme"
    rm -r "${activeDotfilesPath}/core"

    # Copy and stow the new theme
    cp -r "${themeChoicePath}" ${activeDotfilesPath}/main_theme
    cp -r "${dotfilesPath}/core" "${activeDotfilesPath}/core"
    stow -t  $HOME -d "${activeDotfilesPath}" "main_theme"
    stow -t $HOME -d "${activeDotfilesPath}" "core"
 
    # Restart Everything
    pkill waybar
    awww-daemon --no-cache &
    awww img --resize crop -t grow --transition-fps 120 "${wallpaperPath}" &
    waybar &
    bash "${kittyScriptPath}" -r &
    hyprctl reload
    swaync-client -R

    #echo "${choice}" > ${dotfilesPath}/current_theme/current_theme.info
  elif [ "${themeType}" = "waybar" ]; then
    stow -t $HOME -d "${activeDotfilesPath}" -D "waybar_theme"
    rm -r "${activeDotfilesPath}/waybar_theme"

    cp -r "${themeChoicePath}" "${activeDotfilesPath}/waybar_theme"
    stow -t $HOME -d "${activeDotfilesPath}" "waybar_theme"

    pkill waybar
    waybar &
  elif [ "${themeType}" = "core" ]; then
    echo "1"
  elif [ "${themeType}" = "init" ]; then
    echo "2"
  elif [ "${themeType}" = "remove" ]; then
    echo "3"
  elif [ "${themeType}" = "help" ]; then
    echo "4"
  fi
}


powerMenu() {
  requestedTheme="${powerTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi

  options=(
    "󰌾 Lock"
    "󰤄 Hibernate (todo)"
    "󰐥 Shutdown"
    " Reboot"
    "󰍃 Logout"
  )
  confirmationOptions=(" No" " Yes")

  uptimeSeconds=$(cut -d' ' -f1 /proc/uptime)
  uptimeSeconds=${uptimeSeconds%.*}
  
  days=$((uptimeSeconds / 86400))
  hours=$(( (uptimeSeconds % 86400) / 3600 ))
  minutes=$(( (uptimeSeconds % 3600) / 60 ))

  uptime="${days}d ${hours}h ${minutes}m"

  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "" "Uptime: ${uptime}" "" "" "")

  if [ "${choice}" = "" ]; then
    exit
  fi

  requestedTheme="${confirmationTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi
  confirmation=$(printf "%b\n" "${confirmationOptions[@]}" | openMenu "i" "" "" "${options[$choice]}?" "" "")

  
  if [[ "${confirmation}" = "0" || "${confirmation}" = "" ]]; then
    exit
  fi

  case "$choice" in
    0) hyprlock ;;
    1) echo "magic" ;;
    2) poweroff ;;
    3) reboot ;;
    4) hyprctl dispatch exit ;;
  esac
}


powerProfilesMenu() {
  requestedTheme="${powerTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi

  options=(
    "󰈸 Performance" 
    " Balanced"
    " Power Saver"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "Set Power Profile: " "" "" "")

  if [ "${choice}" == "" ]; then
    exit
  fi

  case "${choice}" in
    0) powerprofilesctl set performance ;;
    1) powerprofilesctl set balanced ;;
    2) powerprofilesctl set power-saver ;;
  esac
}



case "$flag" in
  "") menu ;;
  -b) brightnessMenu ;;
  -s) screenshotMenu ;;
  -a) appMenu ;;
  -c) clipboardMenu ;;
  -w) clipboardMenu --alt ;;
  -t) themeMenu ;;
  -p) powerMenu ;;
  -P) powerProfilesMenu ;;
  * ) menu "${flag}" ;;
esac
