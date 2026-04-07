vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })


local hlc = vim.api.nvim_set_hl

hlc(0, "Comment", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "Constant", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "String", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Character", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Number", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Boolean", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Float", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "Identifier", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Function", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "Statement", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Conditional", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Repeat", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Label", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Operator", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Keyword", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Exception", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "PreProc", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Include", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Define", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Macro", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "PreCondit", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "Type", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "StorageClass", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Structure", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Typedef", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "Special", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "SpecialChar", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Tag", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Delimiter", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "SpecialComment", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "Debug", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "Underlined", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "MatchParen", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "Normal", { fg = "#19e650", bg = "NONE", bold = false, italic = false })

hlc(0, "@function", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@method", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@variable", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@parameter", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@type", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@namespace", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@keyword", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@string", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@comment", { fg = "#19e650", bg = "NONE", bold = false, italic = false })



local colors = {}

colors.lualine = {
  normal = {
    a = { fg = "#282828", bg = "#fabd2f", gui = "bold" },
    b = { fg = "#fabd2f", bg = "#3c3836" },
    c = { fg = "#ebdbb2", bg = "NONE" },

    x = { fg = "#fe8019", bg = "NONE" },
    y = { fg = "#fe8019", bg = "NONE" },
    z = { fg = "#282828", bg = "#fabd2f" },
  },
  insert = {
    a = { fg = "#282828", bg = "#3c3836", gui = "bold" },
    b = { fg = "#b8bb26", bg = "#3c3836" },
    c = { fg = "#ebdbb2", bg = "NONE" },

    x = { fg = "#fe8019", bg = "NONE" },
    y = { fg = "#fe8019", bg = "NONE" },
    z = { fg = "#282828", bg = "#fabd2f", gui = "bold" },

  },
  visual = {
    a = { fg = "#282828", bg = "#fe8019", gui = "bold" },
    b = { fg = "#fe8019", bg = "#3c3836" },
    c = { fg = "#ebdbb2", bg = "NONE" },

    x = { fg = "#fe8019", bg = "NONE" },
    y = { fg = "#fe8019", bg = "NONE" },
    z = { fg = "#282828", bg = "#fabd2f", gui = "bold" },

  },
  replace = {
    a = { fg = "#282828", bg = "#fe8019", gui = "bold" },
    b = { fg = "#fe8019", bg = "#3c3836" },
    c = { fg = "#ebdbb2", bg = "NONE" },

    x = { fg = "#fe8019", bg = "NONE" },
    y = { fg = "#fe8019", bg = "NONE" },
    z = { fg = "#282828", bg = "#fabd2f", gui = "bold" },

  },
  command = {
    a = { fg = "#282828", bg = "#fe8019", gui = "bold" },
    b = { fg = "#fe8019", bg = "#3c3836" },
    c = { fg = "#ebdbb2", bg = "NONE" },

    x = { fg = "#fe8019", bg = "NONE" },
    y = { fg = "#fe8019", bg = "NONE" },
    z = { fg = "#282828", bg = "#fabd2f", gui = "bold" },

  },
  inactive = {
    a = { fg = "#282828", bg = "#fe8019", gui = "bold" },
    b = { fg = "#fe8019", bg = "#3c3836" },
    c = { fg = "#ebdbb2", bg = "NONE" },

    x = { fg = "#fe8019", bg = "NONE" },
    y = { fg = "#fe8019", bg = "NONE" },
    z = { fg = "#282828", bg = "#fabd2f" },

  },

}

return colors
