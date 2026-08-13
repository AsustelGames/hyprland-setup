local hc = hl.curve
local t1 = "as"

-- You can either use a spring or bezier not both
local function ha(leaf, speed, bezier, style, spring, enabled)
  print(spring)
  t1 = spring
  hl.animation({
    leaf = leaf,
    enabled = enabled ~= false,
    speed = speed,
    bezier = bezier or nil,
    spring = spring,
    style = style or nil,
  })
end

hl.bind("SUPER + G", hl.dsp.exec_cmd('hyprctl notify "1" "5000" "0" ' .. t1))

hl.config({
  animations = {
    enabled = true,
  },

  decoration = {
    --wobble = {
    --  enabled = true,
    --  mesh = 12,
    --  stiffness = 200,
    --  damping = 12,
    --  mass = 1,
    --  intensity = 0.2,
    --  value_epsilon = 0.25,
    --  velocity_epsilon = 2,
    --},
  },

  --misc = {
  --  animate_manual_resizes = true,
  --  animate_mouse_windowdragging = true,
  --},
})

-- Bezier curves
hc("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} }})
hc("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} }})
hc("linear",         { type = "bezier", points = { {0, 0},       {1, 1} }})
hc("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} }})
hc("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} }})
hc("cubicBezier",    { type = "bezier", points = { {0.6, -0.28}, {0.7, 0.045} }})

-- Springs
hc("spring",         { type = "spring", mass = 1, stiffness = 710, dampening = 20 })
hc("spring2",         { type = "spring", mass = 1, stiffness = 680, dampening = 25 })

-- Animations
ha("global",              10,   "default")
--              Border
ha("border",              3.39, "easeInOutCubic")
ha("borderangle",         18,   "almostLinear")
ha("shadowangle",         18,   "almostLinear")
ha("glowangle",           18,   "almostLinear")
--              Windows
ha("windows",             4.79, "easeOutQuint")
ha("windowsIn",           1.4,  "almostLinear", "gnomed")
ha("windowsOut",          2.29, "cubicBezier",  "popin")
ha("windowsMove",         1.9,  nil,            "popin",        "spring2")
--              Fade
ha("fade",                3,    "quick")
ha("fadeIn",              2,    "almostLinear")
ha("fadeOut",             3,    "almostLinear")
--ha("fadeSwitch",          3,    "almostLinear")
ha("fadeSwitch",          3,    "easeOutQuint")
ha("fadeDim",             5,    "almostLinear")
ha("fadeShadow",          3,    "almostLinear")
ha("fadeGlow",            3,    "almostLinear")
--              Popups
ha("fadePopups",          3,    "almostLinear")
ha("fadePopupsIn",        3,    "almostLinear")
ha("fadePopupsOut",       3,    "almostLinear")
--              Layers
ha("layers",              3.8,  "easeOutQuint")
ha("layersIn",            1.4,  nil,            "popin",        "spring2")
ha("layersOut",           2.49, "cubicBezier",  "popin")
ha("fadeLayers",          3,    "almostLinear")
ha("fadeLayersIn",        1.79, "almostLinear")
ha("fadeLayersOut",       1.39, "almostLinear")
--              Workspaces
ha("workspaces",          1.94, "cubicBezier")
ha("workspacesIn",        2.6,  nil,            "slidevert 2%", "spring")
ha("workspacesOut",       1.8,  "almostLinear", "fade")
ha("specialWorkspace",    2.8,  "linear",       "slidefadevert 2%")
ha("specialWorkspaceIn",  1.8,  "almostLinear", "slidefadevert 2%")
ha("specialWorkspaceOut", 0.8,  "almostLinear", "slidefadevert 2%")
--              Monitors
ha("monitorAdded",        1,    "quick")
ha("fadeDpms",            3,    "almostLinear")
--              Misc
ha("zoomFactor",          1,    "quick")

-- Extra animations
hl.layer_rule({
  name = "rofi-popin",
  match = {
    class = "rofi",
    namespace = "rofi",
  },
  animation = "popin 80%",
})
