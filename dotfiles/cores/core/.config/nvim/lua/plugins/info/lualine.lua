local theme = require("colors")

return {
  {
    "nvim-lualine/lualine.nvim",

    config = function()
      local function lineInfo()
        return " " .. vim.fn.line(".") .. "/" .. vim.fn.line("$")
      end

      local function errorInfo()
        local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

        local errorResult = " "

        if errors > 0 then
          errorResult = "󰅚 " .. errors
        end

        return errorResult
      end

      local function warningInfo()
        local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

        local warningResult = " "

        if warnings > 0 then
          warningResult = " " .. warnings
        end

        return warningResult
      end
      local mode_icons = {
        n = " Normal",
        i = " Insert",
        v = "󰈚 Visual",
        V = "󰈚 V-Line",
        c = " Command",
      }
      local function modeInfo()
        return mode_icons[vim.fn.mode()] or "󱃲 " .. "Mode: " .. vim.fn.mode()
      end
      require("lualine").setup({
        options = {
          theme = theme.lualine,
          component_separators = "",
          section_separators = { left = '', right = '' },
          icons_enabled = true,
          disabled_filetypes = { statusline = { "NvimTree" }, },
        },
        sections = {
          lualine_a = { modeInfo },
          lualine_b = { lineInfo },
          lualine_c = { { "filename", path = 0, symbols = { modified = "[edited]", readonly = "[read-only]", unnamed = "[no name]", } } },
          lualine_x = { errorInfo },
          lualine_y = { warningInfo },
          lualine_z = { { "encoding", icon = "" } },
        }})
    end,
  },
}
