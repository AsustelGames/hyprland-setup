local v = safeRequire(".lua.variables")

local bind = hl.bind
local bindm = hl.bindm

local hd = hl.dsp
local hdl = hl.dsp.layout
local hdw = hl.dsp.window
local hdws = hl.dsp.workspace

-- Programs
bind(v.mainKey .. " + W", hd.exec_cmd(v.browser))

bind(v.mainKey .. " + Q", hd.exec_cmd(v.terminal))
bind(v.mainKey .. " + SHIFT + Q", hd.exec_cmd(v.terminalNormal))

bind(v.mainKey .. " + E", hd.exec_cmd(v.fileManager))
bind(v.mainKey .. " + SHIFT + E", hd.exec_cmd(v.fileManagerNormal))

-- Menus
bind(v.mainKey .. " + A", hd.exec_cmd(v.menu))
bind(v.mainKey .. " + S", hd.exec_cmd(v.appMenu))

bind(v.mainKey .. " + D", hd.exec_cmd(v.clipboardMenu))
bind(v.mainKey .. " + SHIFT + D", hd.exec_cmd(v.clipboardWipeMenu))

bind(v.mainKey .. " + R", hd.exec_cmd(v.screenshotMenu))
bind(v.mainKey .. " + F", hd.exec_cmd(v.themeMenu))


-- Window interactions
bind(v.mainKey .. " + C", hdw.close({}))
bind(v.mainKey .. " + SHIFT + C", hd.exec_cmd(v.forceCloseCommand))

bind(v.mainKey .. " + SHIFT + F", hdw.fullscreen({ mode = "fullscreen" }))

bind(v.mainKey .. " + TAB", hdw.float({}))
bind(v.mainKey .. " + SHIFT + TAB", hdl("togglesplit"))

-- Exiting hyprland
bind(v.mainKey .. " + ESCAPE", hd.exec_cmd(v.powerMenu))
bind(v.mainKey .. " + SHIFT + ESCAPE", hd.exec_cmd("hyprshutdown"))
bind(v.mainKey .. " + ALT + SHIFT + ESCAPE", hd.exit())

-- Move focus
-- Using h,j,k,l or the arrow buttons
bind(v.mainKey .. " + H", hd.focus({ direction = "left" }))
bind(v.mainKey .. " + L", hd.focus({ direction = "right" }))
bind(v.mainKey .. " + K", hd.focus({ direction = "up" }))
bind(v.mainKey .. " + J", hd.focus({ direction = "down" }))

bind(v.mainKey .. " + left", hd.focus({ direction = "left" }))
bind(v.mainKey .. " + right", hd.focus({ direction = "right" }))
bind(v.mainKey .. " + up", hd.focus({ direction = "up" }))
bind(v.mainKey .. " + down", hd.focus({ direction = "down" }))

-- Special workspaces
bind(v.mainKey .. " + Z", hdws.toggle_special("s1"))
bind(v.mainKey .. " + SHIFT + Z", hdw.move({ workspace = "special:s1" }))

bind(v.mainKey .. " + X", hdws.toggle_special("s2"))
bind(v.mainKey .. " + SHIFT + X", hdw.move({ workspace = "special:s2" }))

-- Go and move windows to different workspaces
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  bind(v.mainKey .. " + " .. key, hd.focus({ workspace = i }))
  bind(v.mainKey .. " + SHIFT + " .. key, hdw.move({ workspace = i }))
end

-- Workspace quick switch
-- Using space/shift+space or mouse5/4
bind(v.mainKey .. " + SPACE", hd.focus({ workspace = "m+1" }))
bind(v.mainKey .. " + SHIFT + SPACE", hd.focus({ workspace = "m-1" }))

bind(v.mainKey .. " + mouse:275", hd.focus({ workspace = "m+1" }))
bind(v.mainKey .. " + mouse:276", hd.focus({ workspace = "m-1" }))

-- Drag and move windows
-- Using left & right mouse buttons
bind(v.mainKey .. " + mouse:272", hdw.drag(), { mouse = true })
bind(v.mainKey .. " + mouse:273", hdw.resize(), { mouse = true })
