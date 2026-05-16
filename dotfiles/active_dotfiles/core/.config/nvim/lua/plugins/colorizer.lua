return {
  {
   "norcalli/nvim-colorizer.lua",

    config = function()
      require("colorizer").setup(
        { "*" },
        {
          RGB      = true,     -- #RGB hex codes
          RRGGBB   = true,     -- #RRGGBB hex codes
          names    = true,     -- CSS color names
          RRGGBBAA = true,     -- #RRGGBBAA hex codes
          rgb_fn   = true,     -- highlight rgb() and rgba()
          hsl_fn   = true,     -- highlight hsl() and hsla()
          css      = true,     -- enable all CSS features
          css_fn   = true,     -- enable CSS functions like rgb()
        })
    end,
  },
}
