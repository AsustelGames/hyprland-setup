return {
  {
    "neovim/nvim-lspconfig",

    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require("config.lsp").setup()
    end,
  },
   -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        experimental = {
            ghost_text = true,
        },
        completion = {
          max_item_count = 12,
        },

      window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered({
          border = "rounded",
          max_width = 20,
          max_height = 12,
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          max_width = 20,
          max_height = 15,
        }),
      },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" },
        },
      })

      -- Command line completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "cmdline" },
          { name = "path" },
        },
      })
    end,
  },

  -- CMake
  {
    "Civitasv/cmake-tools.nvim",
      dependencies = {
    "nvim-lua/plenary.nvim",
    },
    config = function()
      require("cmake-tools").setup({})
    end,
  },
}
