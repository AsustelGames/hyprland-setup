function safeRequire(path)
  local status, value = pcall(require, path)

  if not status then
    print("safeRequire(): Failed to load lua file: ", value)
  end

  return value
end

local v = safeRequire(".lua.variables")

-- Enviroment variables
local env = hl.env

env("HYPRCURSOR_THEME", v.cursorTheme)
env("HYPRCURSOR_SIZE", v.cursorSize)

env("XCURSOR_THEME", v.cursorTheme)
env("XCURSOR_SIZE", v.cursorSize)

-- env("SDL_VIDEODRIVER", "wayland")


-- Lua config
safeRequire(".lua.monitors")
safeRequire(".lua.autostart")
safeRequire(".lua.misc")
safeRequire(".lua.window_rules")
safeRequire(".lua.input")
safeRequire(".lua.keybinds")

-- Looks
safeRequire(".looks.decorations")
safeRequire(".looks.animations")
