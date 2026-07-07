local theme = require("colors")

return {
  {
    "nvim-lualine/lualine.nvim",

    config = function()
      local function line_info()
        return vim.fn.line(".") .. "/" .. vim.fn.line("$")
      end
      local function dummy()
        return " "
      end
      require("lualine").setup({
        options = {
          theme = theme.lualine,
          component_separators = "",
          section_separators = { left = '', right = '' },
          icons_enabled = true,
          disabled_filetypes = {
            statusline = { "NvimTree" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { line_info },
          lualine_c = { { "filename", path = 0, symbols = { modified = "[edited]", readonly = "[read-only]", unnamed = "[no name]", } } },
          lualine_x = { "" },
          lualine_y = { "location" },
          lualine_z = { "encoding" },
        }})
    end,
  },
}
