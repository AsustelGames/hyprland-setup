local v = safeRequire(".lua.variables")

local exec = hl.exec_cmd


hl.on("hyprland.start", function ()
  -- Auto mount external storage like flashdrives and ssds
  exec("udiskie &")

  -- Launch useful stuff
  exec("waybar &")
  exec("swaync &")
  --exec("swaync -s ~/.config/swaync/style.css -c ~/.config/swaync/config.json &")

  -- Wallpaper
  exec("awww-daemon &")
  exec("awww img " .. v.wallpaperDir .. " &")

  -- Clipboard
  exec("wl-paste --type text --watch cliphist store &")
  exec("wl-paste --type image --watch cliphist store &")

  -- Cursor theme 
  exec("hyprctl setcursor " .. v.cursorTheme .. " " .. v.cursorSize .. " &")

  -- Create home folder e.g. Downloads, Videos, etc 
  exec("bash " .. v.homeFoldersScript)
end)
