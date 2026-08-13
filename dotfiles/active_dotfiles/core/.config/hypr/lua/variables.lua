-- Custom variables
homeDir = os.getenv("HOME")
local scriptsDir = homeDir .. "/.config/scripts"
local kittyScriptPath = scriptsDir .. "/kitty.sh"
local menuScriptPath = scriptsDir .. "/menu.sh"

return {
  mainKey = "SUPER",

  -- Enviroment
  homeDir = homeDir,
  cursorTheme = "Bibata-Modern-Classic",
  cursorSize = "22",

  -- Commands
  forceCloseCommand = "kill -9 $(hyprctl activewindow -j | jq -r '.pid')",
  volumeUpCommand = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+",
  volumeDownCommand = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-",

  -- Dirs
  wallpaperDir = homeDir .. "/.config/bg.jpg",
  
  -- Scripts/Programs
  homeFoldersScriptPath = scriptsDir .. "/home-folders.sh",
  menuScriptPath = menuScriptPath,
  kittyScriptPath = kittyScriptPath,

  terminal = "bash " .. kittyScriptPath,
  terminalNormal = "kitty",

  browser = "brave",

  fileManager = "bash " .. kittyScriptPath .. " yazi",
  fileManagerNormal = "kitty yazi",
  
  menu = "bash " .. menuScriptPath,
  appMenu = "bash " .. menuScriptPath .. " -a",
  clipboardMenu = "bash " .. menuScriptPath .. " -c",
  clipboardWipeMenu = "bash " .. menuScriptPath .. " -w",
  screenshotMenu = "bash " .. menuScriptPath .. " -s",
  themeMenu = "bash " .. menuScriptPath .. " -t",
  powerMenu = "bash " .. menuScriptPath .. " -p",
}
