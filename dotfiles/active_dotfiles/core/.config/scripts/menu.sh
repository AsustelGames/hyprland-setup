#!/usr/bin/env bash


# Rofi stuff
rofiLogFilePath="$HOME/.rofi.log"
rofiThemeDisablerPath="${activeDotfilesPath}/main_theme/.config/active_theme/disable_rofi_theme"

# Rofi themes
themesPath="$HOME/.config/rofi/themes"
appsTheme="${themesPath}/apps.rasi"
powerTheme="${themesPath}/power.rasi"
confirmationTheme="${themesPath}/confirmation.rasi"
popupTheme="${themesPath}/popup.rasi"
currentTheme=""

# Directory & file paths
screenshotPath="$HOME/Pictures/Screenshots"
dotfilesPath="/etc/nixos/dotfiles"
activeDotfilesPath="${dotfilesPath}/active_dotfiles"
activeThemeHomePath="$HOME/.config/active_theme"
wallpaperPath="${activeThemeHomePath}/bg.jpg"

# Script paths
kittyScriptPath="$HOME/.config/scripts/kitty.sh"
gomplateScriptPath="${dotfilesPath}/cores/core/.config/scripts/gomplate/gomplate.sh"

# Default options for a menu
confirmationOptionClasses=("no" "yes")
confirmationOptions=(" No" "󰗠 Yes")

# Cli stuff
cliModeEnabled=0
cliAction=""
cliPath=""
currentCliInstructionListID=0
cliInstructionList=()

# Misc
menuString=""
flag=$1
flag2=$2
flag3=$3


requestedTheme() {
  # If a theme path is valid it loads the theme,
  # if not it won't load the theme
  #
  # requestedTheme "theme path"
  requestedTheme="$1"

  if [[ -e "${requestedTheme}" && ! -e "${rofiThemeDisablerPath}" ]]; then
    currentTheme="-theme ${requestedTheme}"
  #elif [ -e "${rofiThemeDisablerPath}" ]; then
  #  echo "requestedTheme(): All themes are disabled due to errors"
  #  menuString="All themes are disabled due to errors"
  else
    echo "requestedTheme(): Theme $1 does not exist"
    menuString="Theme: '$1' does not exist"
    currentTheme=""
  fi
}


openMenuFix() {
  # Disables rofi themes if they return errors
  # so you could still use the menu system
  i=0

  while pgrep -x rofi > /dev/null && [ $i -lt 100 ]; do
    sleep 0.1
    ((i++))
  done

  if [ ! -f "${rofiLogFilePath}" ]; then return; fi

  if grep -qi "#error-message" "${rofiLogFilePath}"; then
    notify-send "menu.sh" "Rofi theme has been disabled due to errors. You can try launching it again"
    touch "${rofiThemeDisablerPath}"
  else
    rm -f "${rofiThemeDisablerPath}"
  fi
}


openMenu() {
  # Opens a rofi menu + it does some extra stuff 
  #
  # openMenu "i/-" "dmenu/drun/icons/e" "title" "message/auto" "2/-" "no-mkr/-" "whatever else"
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
    message=""
    if [ "$4" = "auto" ]; then
      if [ ${menuString} != "" ]; then
        message="-mesg"
        messageText="${menuString}"
      fi
    else
      message="-mesg"
      messageText="$4"
    fi
  fi

  if [ "$5" = "2" ]; then
    displayType="-display-columns 2"
  fi

  if [ "$6" = "mkr" ]; then
    markupRows="-markup-rows"
  else
    markupRows=""
  fi

  rm "${rofiLogFilePath}"
  touch "${rofiLogFilePath}"

  openMenuFix &

  rofi -i $returnType $menuType "$3" -display-drun "$3" $message "$messageText" $displayType $currentTheme $markupRows -scroll-method 1 "$7" "$8" -log "${rofiLogFilePath}" &
  echo "rofi -i ${returnType} ${menuType} $3 -display-drun $3 ${message} $4 ${displayType} ${currentTheme}" ${markupRows} -scroll-method 1 "$7" "$8" >&2
}


cli() {
  if [ -z "$1" ]; then
    echo "cli(): No path specified."
    echo ""
    echo "Example path: 'menu/themes/help'"
    echo ""
    echo "Available starting paths:" 
    echo "   'menu', 'brightness', 'power-profiles', 'screenshot', 'apps', 'clipboard', 'wipe-clipboard', 'themes', 'power' and 'help'."
    exit
  fi

  if [ -z "$2" ]; then
    echo "cli(): No instruction provided."
    echo ""
    echo "Available options:" 
    echo "   'run', 'cli-run' and 'cli-run-safe'."

    exit
  fi

  cliModeEnabled=1

  cliPath="$1"
  local path="${1#/}" # Remove the first '/' from $1
  cliAction="$2"
  

  IFS='/' read -ra cliInstructionList <<< "${path}"

  currentCliInstructionListID=0
  case "${cliInstructionList[${currentCliInstructionListID}]}" in
    "") echo "wtf" ;;
    "menu") menu ;;
    "brightness") brightnessMenu ;;
    "power-profiles") powerProfilesMenu ;;
    "screenshot") screenshotMenu ;;
    "apps") appMenu ;;
    "clipboard") clipboardMenu ;;
    "wipe-clipboard") clipboardMenu --alt ;;
    "themes") themeMenu ;;
    "power") powerMenu ;;
    "help") helpMenu ;;
    *)
      echo "cli(): '${cliInstructionList[${currentCliInstructionListID}]}' is not a valid starting path for case."
      echo ""
      echo "Example path: 'menu/themes/help'"
      echo ""
      echo "Available starting paths:" 
      echo "   'menu', 'brightness', 'power-profiles', 'screenshot', 'apps', 'clipboard', 'wipe-clipboard', 'themes', 'power' and 'help'."
      ;;
  esac
}


runMenu() {
  local listSize="${#cliInstructionList[@]}"

  if (( ! cliModeEnabled )); then
    cliAction="run"
  else
    ((currentCliInstructionListID++))
  fi

  declare -n refVar="$1"
  local printfCommand="$2"
  declare -n optionsList="$3"
  declare -n optionClassesList="$4"
  local menuCommand="$5"
  local returnInt=0
  if [ "$6" = "int" ]; then
    local returnInt=1
  fi


  if (( currentCliInstructionListID < listSize )); then
    local name="${cliInstructionList[${currentCliInstructionListID}]}"

    if (( returnInt )); then
      for i in "${!optionClassesList[@]}"; do
        [[ "${optionClassesList[$i]}" == "$name" ]] && refVar="$i" && return
      done
    else
      refVar="$name"
    fi

    return
  fi

  choice="" # Reset choice

  case "${cliAction}" in
    "run") refVar=$("${printfCommand}" "${optionsList[@]}" | ${menuCommand}) ;;
    "cli-run") 
      "${printfCommand}" "Menu: ${cliPath}" "" "> options:" "" "${optionsList[@]}" "" "" "> optionClasses (Path names):" "" "${optionClassesList[@]}"
      ;;
    "cli-run-safe") echo 2765 ;;
    *)
      echo "runMenu(): '${cliAction}' is not a valid action."
      echo ""
      echo "Available options:" 
      echo "   'run', 'cli-run' and 'cli-run-safe'."
      ;;
  esac
}


menu() {
  requestedTheme "${appsTheme}"

  if [ -n "$1" ]; then
    menuString="Error: $0 '$1' is not an option"
    echo "${menuString}"
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
  optionClasses=(
    "brightness"
    "power-profiles"
    "screenshot"
    "apps"
    "clipboard"
    "wipe-clipboard"
    "themes"
    "power"
    "help"
  )
  menuPrintfFunc() { printf "%b\n" "$@"; }
  menuRunFunc() { openMenu "i" "" "" "auto" "" "" ""; }

  runMenu choice menuPrintfFunc options optionClasses menuRunFunc "int"


  case "$choice" in
    0) brightnessMenu ;;
    1) powerProfilesMenu ;;
    2) screenshotMenu ;;
    3) appMenu ;;
    4) clipboardMenu ;;
    5) clipboardMenu --alt ;;
    6) themeMenu ;;
    7) powerMenu ;;
    *) echo "menu(): '${choice}' is not a valid choice for case." ;;
  esac
}


brightnessMenu() {
  requestedTheme "${appsTheme}"
  
  options=($(brightnessctl -l | awk -F"'" '/Device/ {print $2}'))
  optionClasses=($(brightnessctl -l | awk -F"'" '/Device/ {print $2}'))
  
  menuString="Devices with changable brightness"
  menuPrintfFunc() { printf "%b\n" "$@"; }
  menuRunFunc() { openMenu "" "" "" "auto" "" "" "-theme-str" "window { width: 40%; }"; }

  if [ "$1" = "" ]; then
    runMenu device menuPrintfFunc options optionClasses menuRunFunc ""
  fi

  if [ "${device}" = "" ]; then
    exit
  fi

  brightnessPercent=$(brightnessctl -d "${device}" -m | cut -d, -f4)
  
  options=(
    " +10% Brightness (current ${brightnessPercent})"
    " -10% Brightness (minimum 10%)"
  )
  optionClasses=(
    "plus-ten-percent"
    "minus-ten-percent"
  )
  menuPrintfFunc() { printf "%b\n" "$@"; }
  menuRunFunc() { openMenu "i" "" "" "${device}" "" "" ""; }

  runMenu choice menuPrintfFunc options optionClasses menuRunFunc "int"

  if [ "${choice}" == "" ]; then
    exit
  fi

  case "${choice}" in
    0) brightnessctl -d "${device}" s +10% ;;
    1) if [ "${brightnessPercent%\%}" -gt 10 ]; then brightnessctl -d "${device}" s 10%-; fi ;;
    *) echo "brightnessMenu(): '${choice}' is not a valid choice for case." ;;
  esac

  if (( cliModeEnabled )); then
    exit
  fi
  brightnessMenu "${device}"
}


screenshotMenu() {
  requestedTheme "${powerTheme}"

  options=(
    " Screenshot Area"
    " Screenshot Window"
    "󰍹 Screenshot Monitor"
    "󰌁 Colorpicker & Copy"
  )
  optionClasses=(
    "area"
    "window"
    "monitor"
    "color-picker"
  )
  menuPrintfFunc() { printf "%b\n" "$@"; }
  menuRunFunc() { openMenu "i" "" "" "" "" "" ""; }

  runMenu choice menuPrintfFunc options optionClasses menuRunFunc "int"


  case "${choice}" in
    0) exec hyprshot -m region -o "${screenshotPath}" & ;;
    1) exec hyprshot -m window -o "${screenshotPath}" & ;;
    2) exec hyprshot -m output -o "${screenshotPath}" & ;;
    3) exec hyprpicker -a | wl-copy & ;;
    *) echo "screenshotMenu(): '${choice}' is not a valid choice for case." ;;
  esac
}


appMenu() {
  requestedTheme "${appsTheme}"

  # find /nix/store -path "*-user-environment/share/applications/*.desktop" 2>/dev/null
  openMenu "" "icons" "" "" "" ""
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
    pkill -x cava
    pkill waybar
    if [ -z "$(pgrep -a awww)" ]; then
      awww-daemon --no-cache &
    fi
    awww img --resize crop -t grow --transition-fps 120 "${wallpaperPath}" &
    waybar &
    bash "${kittyScriptPath}" -r &
    hyprctl reload
    swaync-client -R
  elif [ "$1" = "waybar" ]; then
    pkill -x cava
    pkill waybar
    waybar &
  else
    echo "dotfiles-reload(): $1 is not a flag"
  fi
}


existing-dotfile-folders-fix() {
  dotfileTrashPath="$HOME/.config/dotfile-trash"
  activeTrashSubdir="$(date "+%H-%M-%S_%d-%m-%Y")"
  mkdir -p "${dotfileTrashPath}/${activeTrashSubdir}"

  isActiveTrashSubdirUseless=1


  dirsToCheck=(
    "hypr"
    "kitty"
    "waybar"
    "rofi"
    "yazi"
    "fastfetch"
    "nvim"
    #"MangoHud"
    #"cava"
    #"mpv"
    #"VSCodium"
    #"btop"
    #"lazygit"
    #"obs-studio"
    #"nvim"
    #"audacity"
    #"i3"
  )

  for dir in "${dirsToCheck[@]}"; do
    if [ -d "$HOME/.config/$dir" ]; then
      isActiveTrashSubdirUseless=0
      mv "$HOME/.config/${dir}" "${dotfileTrashPath}/${activeTrashSubdir}/${dir}"
    fi
  done


  if [ "${isActiveTrashSubdirUseless}" = "1" ]; then
    rmdir "${dotfileTrashPath}/${activeTrashSubdir}"
  fi
}


dotfiles() {
  # dotfiles "stow/unstow/rm/cp" "activeDotfilesPath" "subdir in activeDotfilesPath e.g. core, main_theme or waybar_theme" "path to copy from e.g. actual theme dir path not active dotfiles path"
  func_instruction="$1"
  func_activeDotfilesPath="$2"
  func_activeDotfilesSubdirPath="$3"
  func_dotfilesDirToCopyPath="$4"

  case "${func_instruction}" in
    "") echo "dotfiles(): Error ran a function without an instruction" ;;
    stow)
      echo "stow"
      stow -t "$HOME" -d "${func_activeDotfilesPath}" "${func_activeDotfilesSubdirPath}"
      ;;
    unstow)
      echo "unstow"
      stow -t "$HOME" -d "${func_activeDotfilesPath}" -D "${func_activeDotfilesSubdirPath}"
      ;;
    rm)
      echo "rm"
      rm -r "${func_activeDotfilesPath}/${func_activeDotfilesSubdirPath}"
      ;;
    cp)
      echo "cp"
      cp -r "${func_dotfilesDirToCopyPath}" "${func_activeDotfilesPath}/${func_activeDotfilesSubdirPath}"
      ;;
    *)
      echo "dotfiles(): Error unknown instruction"
      ;;
  esac

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

  CoreInfo=$(<${activeDotfilesPath}/.core_info.txt)
  MainThemeInfo=$(<${activeDotfilesPath}/.main_theme_info.txt)
  waybarThemeInfo=$(<${activeDotfilesPath}/.waybar_theme_info.txt)

  options=(
    "󰈈 Apply/Change Theme"
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
    0) # Apply/Change Theme
      options=(
        "󱞩 Apply/Change Main Theme"
        "󰗉 Apply/Change waybar Theme"
      )

      choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "" "" "" "")

      case "${choice}" in
        "") exit ;;
        0) choice="main"; ActiveThemeName="${MainThemeInfo}" ;;
        1) choice="waybar"; ActiveThemeName="${waybarThemeInfo}" ;;
      esac

      themeType="${choice}"

      #if [ ! -d "${dotfilesPath}/themes/${choice}" ]; then
      #  echo "Error: path ${dotfilesPath}/themes/${choice} does not exist"
      #  openMenu "i" "" "" "Error: path ${dotfilesPath}/themes/${choice} does not exist" "" ""
      #  exit
      #fi

      choice=$(ls "${dotfilesPath}/themes/${themeType}" | openMenu "" "" "" "Currently Using: ${ActiveThemeName}" "" "")

      [ "${choice}" != "" ] || exit

      selectedTheme="${dotfilesPath}/themes/${themeType}/${choice}"
      selectedThemeName="${choice}"

      # hardcoded
      selectedCore="${dotfilesPath}/cores/core"
      selectedCoreName="core"
      ;;

    1) # Initialize Dotfiles
      #requestedTheme "${confirmationTheme}"

      #confirmationOptions=(" No" " Info" "󰗠 Yes")

      #confirmation=$(printf "%b\n" "${confirmationOptions[@]}" | openMenu "i" "" "" "${options[$choice]}?" "" "")

      #if [[ "${confirmation}" = "0" || "${confirmation}" = "" ]]; then
      #  exit
      #fi

      #echo bruh
      choice=$(basename "$(find "${dotfilesPath}/themes/main" -mindepth 1 -maxdepth 1 -type d | head -n1)")
      choice2=$(basename "$(find "${dotfilesPath}/themes/waybar" -mindepth 1 -maxdepth 1 -type d | head -n1)")
      echo "${choice}" > "${activeDotfilesPath}/.waybar_theme_info.txt"
      waybarThemeInfo=$(<${activeDotfilesPath}/.waybar_theme_info.txt)
      selectedTheme="${dotfilesPath}/themes/main/${choice}"
      selectedThemeName="${choice}"

      # hardcoded
      selectedCore="${dotfilesPath}/cores/core"
      selectedCoreName="core"
      themeType="main"
      ;;

    2) # Reload Active dotfiles
      dotfiles-reload "all"
      ;;

    3) # Restore Active dotfiles
      if [ -d "${activeThemeHomePath}" ]; then
        echo "todo"
        exit
      fi

      existing-dotfile-folders-fix
      dotfiles "stow" "${activeDotfilesPath}" "main_theme" ""
      dotfiles "stow" "${activeDotfilesPath}" "core" ""
      dotfiles "stow" "${activeDotfilesPath}" "waybar_theme" ""
      dotfiles-reload "all"
      ;;

    4) # Disable Active Dotfiles
      [ -d "${activeDotfilesPath}" ] || exit

      confirmationOptions=(" No" "󰗠 Yes")
      requestedTheme "${confirmationTheme}"
      confirmation=$(printf "%b\n" "${confirmationOptions[@]}" | openMenu "i" "" "" "${options[$choice]}?" "" "")

      if [[ "${confirmation}" = "0" || "${confirmation}" = "" ]]; then
        exit
      fi

      dotfiles "unstow" "${activeDotfilesPath}" "main_theme" ""
      dotfiles "unstow" "${activeDotfilesPath}" "core" ""
      dotfiles "unstow" "${activeDotfilesPath}" "waybar_theme" ""
      dotfiles-reload "all"
      ;;

    5) # Advanced Options
      options=(
        " Remove & Re-Apply Active Dotfiles"
        " Change Core"
        " Delete Active Dotfiles"
        " Save Active dotfiles"
        " Build Active Dotfiles"
        " Help"
      )
      choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" " " "" "" "")
      ;;

    6) # Help
      requestedTheme "${popupTheme}"

      openMenu "" "e" "${helpMessage}" "" "" "" "-markup" ;;
  esac


  #count=$(find ${dotfilesPath}/cores -mindepth 1 -maxdepth 1 -type d | wc -l)

  #if [ "${count}" -gt 1 ]; then
  #  echo "More than one directory in cores"
  #fi

  themeYamlPath="${activeDotfilesPath}/main_theme/.config/active_theme/theme.yaml"
  #themeYamlPathClean="${selectedTheme}/.config/active_theme/theme.yaml"

  mkdir -p "${activeDotfilesPath}" 
  
  if [ "${themeType}" = "main" ]; then
    # Remove and unstow the previous theme
    dotfiles "unstow" "${activeDotfilesPath}" "main_theme" ""
    dotfiles "unstow" "${activeDotfilesPath}" "core" ""
    dotfiles "rm" "${activeDotfilesPath}" "main_theme" ""
    dotfiles "rm" "${activeDotfilesPath}" "core" ""

    # Copy and stow the new theme
    dotfiles "cp" "${activeDotfilesPath}" "main_theme" "${selectedTheme}"
    dotfiles "cp" "${activeDotfilesPath}" "core" "${selectedCore}"

    # Gomplate stuff
    if [ -e "${themeYamlPath}" ]; then
      bash "${gomplateScriptPath}" "${activeDotfilesPath}" "${themeYamlPath}"
    fi

    existing-dotfile-folders-fix

    dotfiles "stow" "${activeDotfilesPath}" "main_theme" ""
    dotfiles "stow" "${activeDotfilesPath}" "core" ""

    # Gomplate stuff
    if [ -e "${themeYamlPath}" ]; then
      dotfiles "unstow" "${activeDotfilesPath}" "waybar_theme" ""
      dotfiles "rm" "${activeDotfilesPath}" "waybar_theme" ""
      dotfiles "cp" "${activeDotfilesPath}" "waybar_theme" "${dotfilesPath}/themes/waybar/${waybarThemeInfo}"
      dotfiles "stow" "${activeDotfilesPath}" "waybar_theme" ""

      bash "${gomplateScriptPath}" "${activeDotfilesPath}" "${themeYamlPath}"
    fi

    # Restart Everything
    dotfiles-reload "all"

    echo "${selectedCoreName}" > "${activeDotfilesPath}/.core_info.txt"
    echo "${selectedThemeName}" > "${activeDotfilesPath}/.main_theme_info.txt"

    mkdir -p "${activeDotfilesPath}/main_theme/.config/active_theme"
    cp "${activeDotfilesPath}/.core_info.txt" "${activeDotfilesPath}/main_theme/.config/active_theme"
    cp "${activeDotfilesPath}/.main_theme_info.txt" "${activeDotfilesPath}/main_theme/.config/active_theme"
    cp "${activeDotfilesPath}/.waybar_theme_info.txt" "${activeDotfilesPath}/main_theme/.config/active_theme"

  elif [ "${themeType}" = "waybar" ]; then
    # Remove and unstow the previous theme
    dotfiles "unstow" "${activeDotfilesPath}" "waybar_theme" ""
    dotfiles "rm" "${activeDotfilesPath}" "waybar_theme" ""

    # Copy and stow the new theme
    dotfiles "cp" "${activeDotfilesPath}" "waybar_theme" "${selectedTheme}"
    dotfiles "stow" "${activeDotfilesPath}" "waybar_theme" ""

    if [ -e "${themeYamlPath}" ]; then
      bash "${gomplateScriptPath}" "${activeDotfilesPath}/waybar_theme" "${themeYamlPath}"
    fi

    # Restart Everything
    dotfiles-reload "waybar"

    echo "bash '${gomplateScriptPath}' '${activeDotfilesPath}/waybar_theme' '${themeYamlPath}'"

    echo "${selectedThemeName}" > "${activeDotfilesPath}/.waybar_theme_info.txt"

  elif [ "${themeType}" = "core" ]; then
    echo "1"
  fi
}


powerMenu() {
  requestedTheme "${powerTheme}"

  options=(
    "󰌾 Lock (disabled)"
    "󰤄 Hibernate (no feature)"
    "󰐥 Shutdown"
    " Reboot"
    "󰍃 Logout"
    " Force Logout"
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
    0) echo hyprlock ;;
    1) echo hibernate ;;
    2) poweroff ;;
    3) reboot ;;
    4) hyprshutdown ;;
    5) hyprctl dispatch exit ;;
  esac
}


powerProfilesMenu() {
  requestedTheme "${powerTheme}"

  options=(
    "󰈸 Performance" 
    " Balanced"
    " Power Saver"
  )
  choice=$(printf "%b\n" "${options[@]}" | openMenu "i" "" "Set Power Profile: " "${menuString}" "" "")

  if [ "${choice}" == "" ]; then
    exit
  fi

  case "${choice}" in
    0) powerprofilesctl set performance ;;
    1) powerprofilesctl set balanced ;;
    2) powerprofilesctl set power-saver ;;
  esac
}


helpMenu() {
  # store all help info here
  echo "help"
}



case "$flag" in
  # Menus
  "") menu ;;
#  -h) ;;
  "-b") brightnessMenu ;;
  "-s") screenshotMenu ;;
  "-a") appMenu ;;
  "-c") clipboardMenu ;;
  "-w") clipboardMenu --alt ;;
  "-t") themeMenu ;;
  "-p") powerMenu ;;
  "-P") powerProfilesMenu ;;

  # Special script functions
#  --help) ;;
  "--cli") cli "${flag2}" "${flag3}" ;;
  "--reload-all-dotfiles") dotfiles-reload "all" ;;
  "--initialize-dotfiles") echo "no code" ;;

  # Return error if flag not valid
  *) menu "${flag}" ;; # what if user is in cli
esac

