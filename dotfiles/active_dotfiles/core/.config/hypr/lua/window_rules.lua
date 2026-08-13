local window_rule = hl.window_rule

-- Window rules
window_rule({
  name  = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

window_rule({
  name  = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

window_rule({
  name = "auto-floating-programs",
  match = {
    initial_class = "floating-program",
  },
  float = true,
  size = {"monitor_w * 0.9", "monitor_h * 0.8"},
})

-- Window/Layout config
hl.config({
  general = {
    resize_on_border = false,
    allow_tearing = false,

    layout = "dwindle",
  },

  dwindle = {
    preserve_split = true,
  },

  --master = {
  --  new_status = "master",
  --},

  xwayland = {
    force_zero_scaling = true,
  },
})
