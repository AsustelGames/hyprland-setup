local ts_languages = {
  "cpp",
  "c",
  "markdown",
  "css",
  "qmljs",
  "json",
  "lua",
  "nix",
  "cmake",
  "bash",
  "zsh",
  "yaml",
}

return {
  { "HiPhish/rainbow-delimiters.nvim", },

  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = { "HiPhish/rainbow-delimiters.nvim", },
    main = "ibl",

    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup {
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
          show_exact_scope = true,
          highlight = highlight,
        },
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
  
  {
   "norcalli/nvim-colorizer.lua",

    config = function()
      require("colorizer").setup(
        { "*" },
        {
          RGB      = true, -- #RGB hex codes
          RRGGBB   = true, -- #RRGGBB hex codes
          names    = true, -- CSS color names
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn   = true, -- highlight rgb() and rgba()
          hsl_fn   = true, -- highlight hsl() and hsla()
          css      = true, -- enable all CSS features
          css_fn   = true, -- enable CSS functions like rgb()
        })
    end,
  },

  {
    "tzachar/highlight-undo.nvim",

    config = function()
      require('highlight-undo').setup({
        opts = {
          hlgroup = "HighlightUndo",
          duration = 250,
          pattern = {"*"},
          ignored_filetypes = { "NvimTree", "lazy", },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",

    lazy = false,
    build = ":TSUpdate",

    config = function() 
      require('nvim-treesitter').install(ts_languages):wait(300000)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = ts_languages,
        callback = function(args)
          vim.treesitter.start(args.buf)
        end,
      })
    end,
  },
}
