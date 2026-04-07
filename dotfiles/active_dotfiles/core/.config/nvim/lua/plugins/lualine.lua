local theme = require("colors")

return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function line_info()
        local current = vim.fn.line(".")
        local total = vim.fn.line("$")
        return current .. "/" .. total
      end
      require("lualine").setup({
        options = {
          theme = theme.lualine, --match your colorscheme
          component_separators = { left = '/', right = '/' },
          section_separators = { left = '', right = '' },
          icons_enabled = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { line_info },
          lualine_c = {
            {
              "filename",
              path = 0,
              symbols = {
                modified = "[edited]",
                readonly = "[read-only]",
                unnamed = "[no name]",
              }
            }
          },
          lualine_x = { "location" },
          lualine_y = { "" },
          lualine_z = { "encoding" },
        },
      })
    end,
  },
}
