hl.config({
  misc = {
    disable_autoreload = true,

    disable_hyprland_logo = true,
    disable_splash_rendering = false,
    background_color = "rgba(00000000)",
    vrr = 2,
  },

  ecosystem = {
    enforce_permissions = true,
    no_donation_nag = true,
  },
})

-- Restart after editing permissions
hl.permission({
  binary = "/nix/store/[a-z0-9]{32}-obs-studio-[^/]+/bin/obs-studio",
  type = "screencopy",
  mode = "allow",
})
hl.permission({
  binary = "/nix/store/[a-z0-9]{32}-discord-[^/]+/bin/discord",
  type = "screencopy",
  mode = "allow",
})
hl.permission({
  binary = "/nix/store/[a-z0-9]{32}-hyprpicker-[^/]+/bin/hyprpicker",
  type = "screencopy",
  mode = "allow",
})
hl.permission({
  binary = "/nix/store/[a-z0-9]{32}-hyprlock-[^/]+/bin/hyprlock",
  type = "screencopy",
  mode = "allow",
})
