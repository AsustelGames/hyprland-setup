return {
  {
    "goolord/alpha-nvim",

    config = function()
      local startpage = require("config.startpage")

      require("alpha").setup(
        startpage.config
      )
    end,
  },
}
