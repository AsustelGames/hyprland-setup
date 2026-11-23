#!/usr/bin/env bash


# find /run/current-system/sw/share/applications -iname '*nvim*.desktop'
# cat /run/current-system/sw/share/applications/nvim.desktop

# grep -ril "youtube" ~/.local/share/applications/

appsDir="$HOME/.local/share/applications"

mkdir -p "${appsDir}"

hide() {
  filename="$1"
  desktopName="$2"

  [[ -z "${filename}" || -z "${desktopName}" ]] && echo "Please specify an app to hide" && exit

  cat > "${appsDir}/${filename}.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=${desktopName}
Hidden=true
EOF
}


hide "nvim" "Neovim Wrapper"
hide "uuctl" "uuctl"
hide "btop" "btop++"
hide "mpv" "mpv Media Player"
hide "yazi" "Yazi File Manager"

hide "nixos-manual" "NixOS Manual"

hide "rofi" "Rofi"
hide "rofi-theme-selector" "Rofi Theme Selector"
hide "kando" "Kando"

hide "writer" "LibreOffice Writer"
hide "base" "LibreOffice Base"
hide "calc" "LibreOffice Calc"
hide "draw" "LibreOffice Draw"
hide "impress" "LibreOffice Impress"
hide "math" "LibreOffice Math"

