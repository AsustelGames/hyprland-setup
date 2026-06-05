#!/usr/bin/env bash


themesPath="$HOME/.config/rofi/themes"
appsTheme="${themesPath}/apps.rasi"
powerTheme="${themesPath}/power.rasi"
confirmationTheme="${themesPath}/confirmation.rasi"
popupTheme="${themesPath}/popup.rasi"
currentTheme=""

screenshotPath="$HOME/Pictures/Screenshots"
dotfilesPath="/etc/nixos/dotfiles"
wallpaperPath="$HOME/.config/bg.jpg"

kittyScriptPath="$HOME/.config/scripts/kitty.sh"

confirmationOptions=(" No" "󰗠 Yes")

errorString=""
flag=$1


requestedTheme() {
  requestedTheme="$1"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  else
    echo "requestedTheme(): Theme $1 does not exist"
    errorString="Theme "$1" does not exist"
  fi
}


openMenu() {
  #openMenu "i/-" "dmenu/drun/icons/e" "title" "message" "2/-" "no-mkr/-" "whatever else"
  if [ "$1" = "i" ]; then # Return int
    returnType="-format i"
  fi

  if [ "$2" = "drun" ]; then
    menuType="-show drun -p"
  elif [ "$2" = "e" ]; then
    menuType="-e"
  elif [ "$2" = "icons" ]; then
    menuType="-show drun -show-icons -p"
  else
    menuType="-dmenu -p"
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

  rofi -i $returnType $menuType "$3" -display-drun "$3" $message "$4" $displayType $currentTheme $markupRows -scroll-method 1 "$7" "$8"
  echo "rofi -i ${returnType} ${menuType} $3 -display-drun $3 ${message} $4 ${displayType} ${currentTheme}" ${markupRows} -scroll-method 1 "$7" "$8" >&2
}


menu() {
  requestedTheme "${appsTheme}"

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
  requestedTheme "${clipboardTheme}"
  
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
  requestedTheme "${powerTheme}"

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
  requestedTheme "${appsTheme}"

  openMenu "" "icons" "Apps: " "" "" ""
}


clipboardMenu() {
  confirmationOptions=(" No" " Yes")

  if [ "$1" = "--alt" ]; then
    requestedTheme "${confirmationTheme}"

    confirmation=$(printf "%b\n" "${confirmationOptions[@]}" | openMenu "i" "" "" "Wipe clipboard?" "" "")

  
    if [[ "${confirmation}" = "0" || "${confirmation}" = "" ]]; then
      exit
    fi
    cliphist wipe
  fi
  
  requestedTheme "${appsTheme}"

  cliphist list | openMenu "" "" "Clipboard: " "" "2" "" "-theme-str" "window { width: 40%; }" | cliphist decode | wl-copy
}


dotfiles-reload() {
  # dotfiles-reload "-/all/waybar"
  if [[ "$1" = "" || "$1" = "all" ]]; then
    pkill waybar
    awww-daemon --no-cache &
    awww img --resize crop -t grow --transition-fps 120 "${wallpaperPath}" &
    waybar &
    bash "${kittyScriptPath}" -r &
    hyprctl reload
    swaync-client -R
  elif [ "$1" = "waybar" ]; then
    pkill waybar
    waybar &
  else
    echo "dotfiles-reload(): $1 is not a flag"
  fi
}


dotfiles() {
  # dotfiles "stow/unstow/rm/cp" "activeDotfilesPath" "subdir in activeDotfilesPath e.g. core, main_theme or waybar_theme" "path to copy from e.g. actual theme dir path not active dotfiles path"
  echo "todo"
}


themeMenu() {
  echo "Running themeMenu"
  requestedTheme "${appsTheme}"

  helpMessage='<span size="x-large"> Help</span>

<b>󰈈 Apply Theme</b>
 -> Lets you select and apply a theme.

<b> Initialize Dotfiles</b>
 -> Automaticly applies a theme.

<b>󰜉 Reload Active Dotfiles</b>
 -> Reloads active dotfiles.

<b>󰑓 Restore Active Dotfiles</b>
 -> Enables the inactive
 dotfiles.

<b> Disable Active Dotfiles</b>
 -> Disables the active dotfiles
 but does not delete them.

<b> Advanced Options</b>
 -> Reveals more advanced options.
  '
  options=(
    "󰈈 Apply Theme"
    " Initialize Dotfiles"
    "󰜉 Reload Active Dotfiles"
    "󰑓 Restore Active Dotfiles"
    " Disable Active Dotfiles"
    " Advanced Options"
    " Help"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" " " "" "" "")

  case "${choice}" in
    "") exit ;;
    0) # Apply Theme
      options=(
        "󱞩 Apply Main Theme"
        "󰗉 Apply waybar Theme"
      )

      choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "" "" "" "")

      case "${choice}" in
        "") exit ;;
        0) choice="main" ;;
        1) choice="waybar" ;;
        2) echo "No code" ;;
        3) echo "No code" ;;
      esac

      if [ ! -d "${dotfilesPath}/themes/${choice}" ]; then
        echo "Error: path ${dotfilesPath}/themes/${choice} does not exist"
        openMenu "i" "" "" "Error: path ${dotfilesPath}/themes/${choice} does not exist" "" ""
        exit
      fi

      choice=$(ls "${dotfilesPath}/themes/${choice}" | openMenu "i" "" "" "" "" "")
      ;;
    1) # Initialize Dotfiles
      choice="applyTheme"
      ;;
    2) # Reload Active dotfiles
      choice="applyTheme"
      ;;
    3) # Restore Active dotfiles
      choice="applyTheme"
      ;;
    4) # Disable Active Dotfiles
      [ -d "${activeDotfilesPath}" ] || exit

      confirmationOptions=(" No" " Info" "󰗠 Yes")
      requestedTheme "${confirmationTheme}"
      confirmation=$(printf "%b\n" "${confirmationOptions[@]}" | openMenu "i" "" "" "${options[$choice]}?" "" "")

      if [[ "${confirmation}" = "0" || "${confirmation}" = "" ]]; then
        exit
      fi

      stow -t $HOME -d "${activeDotfilesPath}" -D "main_theme"
      stow -t $HOME -d "${activeDotfilesPath}" -D "core"
      ;;
    5) # Advanced Options
      options=(
        " Remove & Re-Apply Active Dotfiles"
        " Change Core"
        " Delete Active Dotfiles"
        " Save Active dotfiles"
        " Disable Active Dotfiles"
        " Build Active Dotfiles"
        " Help"
      )
      choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" " " "" "" "")
      ;;
    6) # Help
      requestedTheme "${popupTheme}"

      openMenu "" "e" "${helpMessage}" "" "" "" "-markup" ;;
  esac
  
  if [ "${themeType}" != "" ]; then
    choice=$(ls "${dotfilesPath}/themes/${themeType}" | openMenu "" "" "Themes: " "" "" "")
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
  requestedTheme "${powerTheme}"

  options=(
    "󰌾 Lock"
    "󰤄 Hibernate (todo)"
    "󰐥 Shutdown"
    " Reboot"
    "󰍃 Logout"
  )

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

  requestedTheme "${confirmationTheme}"
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
  requestedTheme "${powerTheme}"

  options=(
    "󰈸 Performance" 
    " Balanced"
    " Power Saver"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "Set Power Profile: " "${errorString}" "" "")

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

themeMenuBackup() {
  echo "Running themeMenu"
  requestedTheme="${appsTheme}"
  if [ -e "${requestedTheme}" ]; then
    currentTheme="-theme ${requestedTheme}"
  fi
  options=(
    "󰈈 Apply Theme"
    " Initialize Dotfiles"
    "󰜉 Reload Active dotfiles"
    "󰑓 Restore Active dotfiles"
    " Disable Active Dotfiles"
    " Advanced Options"
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

