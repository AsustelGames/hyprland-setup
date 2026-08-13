hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 10,

    border_size = 3,

    col = {
      active_border = "rgba(CAD277FF)",
      inactive_border = "rgba(A2B057FF)",
    },
  },

  decoration = {
    --screen_shader = "~/.config/hypr/looks/bloom.frag",

    rounding = 8,
    rounding_power = 3,

    active_opacity = 1,
    inactive_opacity = 0.85,

    dim_inactive = true,
    dim_strength = 0.1,

    shadow = {
      enabled = true,
      range = 5,
      render_power = 3,
      color = "rgba(173626ee)",
    },

    blur = {
      enabled = true,
      size = 3,
      passes = 5,
      noise = 0.07,
      vibrancy = 0.23,
      vibrancy_darkness = 1,
      brightness = 1.2,
      popups = true,
      special = true,
    },

    glow = {
      enabled = true,
      render_power = 3,
      range = 5,
      color = "rgba(FFFFFFFF)",
      color_inactive = "rgba(FF00FFFF)",
    },

    motion_blur = {
      enabled = false,
      samples = 7,
    },

  },
})

hl.window_rule({
  name = "kitty-opacity",
  match = {
    class = "kitty",
  },
  opacity = "0.9 0.8",
})

hl.layer_rule({
  name = "rofi-blur",
  match = {
    namespace = "rofi",
  },
  blur = true,
  ignore_alpha = 0.1,
})

hl.layer_rule({
  name = "waybar-blur",
  match = {
    namespace = "waybar",
  },
  blur = true,
  ignore_alpha = 0.7,
})
