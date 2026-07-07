function reloadTheme()
    package.loaded["colors"] = nil
    require("lazy").reload({ plugins = { "lualine.nvim" } })
end


local hlc = vim.api.nvim_set_hl


-- Colors
local colors = {}

colors.background = "#5F485C"
colors.foreground = "#FFEFDF"
colors.primary = "#FDAE96"
colors.secondary = "#EC8175"

colors.black = "#2E3436"
colors.black2 = "#555753"

colors.red = "#CC0000"
colors.red2 = "#EF2929"

colors.green = "#4E9A06"
colors.green2 = "#8AE234"

colors.yellow = "#C4A000"
colors.yellow2 = "#FCE94F"

colors.blue = "#3465A4"
colors.blue2 = "#729FCF"

colors.pink = "#75507B"
colors.pink2 = "#AD7FA8"

colors.cyan = "#06989A"
colors.cyan2 = "#34E2E2"

colors.white = "#D3D7CF"
colors.white2 = "#EEEEEC"

colors.none = colors.background


colors.lualine = {
  normal = {
    a = { fg = colors.none, bg = colors.primary, gui = "bold" },
    b = { fg = colors.primary, bg = colors.black },
    c = { fg = colors.foreground, bg = colors.none, gui = "italic" },

    x = { fg = colors.primary, bg = colors.none },
    y = { fg = colors.primary, bg = colors.none },
    z = { fg = colors.none, bg = colors.secondary, gui = "bold" },
  },
  insert = {
    a = { fg = colors.none, bg = colors.blue2, gui = "bold" },
    b = { fg = colors.blue2, bg = colors.black },

    y = { fg = colors.blue2, bg = colors.none },
    z = { fg = colors.none, bg = colors.secondary, gui = "bold" },
  },
  visual = {
    a = { fg = colors.none, bg = colors.yellow2, gui = "bold" },
    b = { fg = colors.yellow2, bg = colors.black },

    y = { fg = colors.yellow2, bg = colors.none },
    z = { fg = colors.none, bg = colors.secondary, gui = "bold" },
  },
  replace = {
    a = { fg = colors.none, bg = colors.green2, gui = "bold" },
    b = { fg = colors.green2, bg = colors.black },

    y = { fg = colors.green2, bg = colors.none },
    z = { fg = colors.none, bg = colors.secondary, gui = "bold" },
  },
  command = {
    a = { fg = colors.none, bg = colors.cyan2, gui = "bold" },
    b = { fg = colors.cyan2, bg = colors.black },

    y = { fg = colors.cyan2, bg = colors.none },
    z = { fg = colors.none, bg = colors.secondary, gui = "bold" },
  },
  inactive = {
    y = { fg = colors.foreground, bg = colors.none },
  },
}




-- Nvim
hlc(0, "Normal", { fg = colors.foreground, bg = "NONE", bold = false, italic = false })

hlc(0, "NormalFloat", { fg = colors.foreground, bg = "NONE", bold = false, italic = false })
hlc(0, "FloatBorder", { fg = colors.primary, bg = "NONE", bold = false, italic = false })

hlc(0, "NonText", { fg = colors.black2 })
hlc(0, "SpecialKey", { fg = colors.black2 })

hlc(0, "LineNr", { fg = colors.black2, bg = "NONE", bold = false, italic = false })
hlc(0, "CursorLineNr", { fg = colors.primary, bg = "NONE", bold = true, italic = false })

hlc(0, "StatusLine", { bg = "NONE" })
hlc(0, "StatusLineNC", { bg = "NONE" })

hlc(0, "Visual", { bg = colors.black2 })
hlc(0, "CursorLine", { bg = colors.black })
hlc(0, "CursorColumn", { bg = colors.black })


-- Barbar
hlc(0, "BufferScrollArrow", { fg = colors.primary, bg = colors.none })

hlc(0, "BufferCurrentBtn", { fg = colors.primary, bg = colors.none })
hlc(0, "BufferInactiveBtn", { fg = Normal, bg = colors.none })
hlc(0, "BufferVisibleBtn", { fg = Normal, bg = colors.none })

hlc(0, "BufferCurrentSign", { fg = colors.none, bg = colors.primary })
hlc(0, "BufferInactiveSign", { fg = Normal, bg = colors.none })

hlc(0, "BufferCurrentSignRight", { fg = colors.none, bg = colors.primary })
hlc(0, "BufferInactiveSignRight", { fg = Normal, bg = colors.none })


-- Tree
hlc(0, "NvimTreeExecFile", { fg = colors.green2, bg = "NONE", bold = true, italic = true, underline = false })
hlc(0, "NvimTreeSpecialFile", { fg = colors.yellow2, bg = "NONE", bold = false, italic = true, underline = false })
hlc(0, "NvimTreeSymlink", { fg = colors.blue2, bg = "NONE", bold = false, italic = true, underline = true })
hlc(0, "NvimTreeImageFile", { fg = colors.primary, bg = "NONE", bold = false, italic = true, underline = false })


-- Syntax
hlc(0, "Comment", { fg = colors.green, bg = "NONE", bold = false, italic = true })

hlc(0, "Constant", { fg = colors.blue2, bg = "NONE", bold = false, italic = false })
hlc(0, "String", { fg = colors.yellow, bg = "NONE", bold = false, italic = false })
hlc(0, "Character", { fg = colors.yellow, bg = "NONE", bold = false, italic = false })
hlc(0, "Number", { fg = colors.green2, bg = "NONE", bold = false, italic = false })
hlc(0, "Boolean", { fg = colors.blue2, bg = "NONE", bold = false, italic = false })
hlc(0, "Float", { fg = colors.green2, bg = "NONE", bold = false, italic = false })

hlc(0, "Identifier", { fg = colors.cyan2, bg = "NONE", bold = false, italic = false })
--hlc(0, "Function", { fg = colors.red, bg = "NONE", bold = false, italic = false })

hlc(0, "Statement", { fg = colors.pink2, bg = "NONE", bold = false, italic = false })
hlc(0, "Conditional", { fg = colors.pink2, bg = "NONE", bold = false, italic = false })
hlc(0, "Repeat", { fg = colors.pink2, bg = "NONE", bold = false, italic = false })
hlc(0, "Label", { fg = colors.pink2, bg = "NONE", bold = false, italic = false })
hlc(0, "Operator", { fg = colors.yellow2, bg = "NONE", bold = false, italic = false })
--hlc(0, "Keyword", { fg = colors.red, bg = "NONE", bold = false, italic = false })
hlc(0, "Exception", { fg = colors.pink2, bg = "NONE", bold = false, italic = false })

--hlc(0, "PreProc", { fg = colors.red, bg = "NONE", bold = false, italic = false })
hlc(0, "Include", { fg = colors.pink2, bg = "NONE", bold = false, italic = false })
--hlc(0, "Define", { fg = colors.red, bg = "NONE", bold = false, italic = false })
hlc(0, "Macro", { fg = colors.pink2, bg = "NONE", bold = false, italic = false })
hlc(0, "PreCondit", { fg = colors.pink2, bg = "NONE", bold = false, italic = false })

hlc(0, "Type", { fg = colors.blue2, bg = "NONE", bold = false, italic = false })
hlc(0, "StorageClass", { fg = colors.blue2, bg = "NONE", bold = false, italic = false })
hlc(0, "Structure", { fg = colors.blue2, bg = "NONE", bold = false, italic = false })
--hlc(0, "Typedef", { fg = colors.red, bg = "NONE", bold = false, italic = false })

--hlc(0, "Special", { fg = colors.red, bg = "NONE", bold = false, italic = false })
hlc(0, "SpecialChar", { fg = colors.yellow2, bg = "NONE", bold = true, italic = false })
--hlc(0, "Tag", { fg = colors.red, bg = "NONE", bold = false, italic = false })
--hlc(0, "Delimiter", { fg = colors.red, bg = "NONE", bold = false, italic = false })
--hlc(0, "SpecialComment", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
--hlc(0, "Debug", { fg = colors.red, bg = "NONE", bold = false, italic = false })

--hlc(0, "Underlined", { fg = colors.red, bg = "NONE", bold = false, italic = false })
hlc(0, "MatchParen", { fg = colors.primary, bg = "NONE", bold = false, italic = false, underline = true })


hlc(0, "@function", { fg = colors.yellow2, bg = "NONE", bold = false, italic = false })
--hlc(0, "@method", { fg = colors.red, bg = "NONE", bold = false, italic = false })
hlc(0, "@variable", { fg = colors.cyan2, bg = "NONE", bold = false, italic = false })
--hlc(0, "@parameter", { fg = colors.red, bg = "NONE", bold = false, italic = false })
hlc(0, "@type", { fg = colors.green2, bg = "NONE", bold = false, italic = false })
--hlc(0, "@namespace", { fg = colors.red, bg = "NONE", bold = false, italic = false })
--hlc(0, "@keyword", { fg = colors.red, bg = "NONE", bold = false, italic = false })
--hlc(0, "@string", { fg = colors.red, bg = "NONE", bold = false, italic = false })
--hlc(0, "@comment", { fg = colors.red, bg = "NONE", bold = false, italic = false })


return colors
