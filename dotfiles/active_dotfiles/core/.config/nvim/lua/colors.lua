vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })


local hlc = vim.api.nvim_set_hl

hlc(0, "Comment", { fg = "#4E9A06", bg = "NONE", bold = false, italic = true })

hlc(0, "Constant", { fg = "#FCE94F", bg = "NONE", bold = true, italic = false })
hlc(0, "String", { fg = "#8AE234", bg = "NONE", bold = true, italic = false })
hlc(0, "Character", { fg = "#8AE234", bg = "NONE", bold = false, italic = false })
hlc(0, "Number", { fg = "#34E2E2", bg = "NONE", bold = true, italic = false })
hlc(0, "Boolean", { fg = "#FCE94F", bg = "NONE", bold = true, italic = false })
hlc(0, "Float", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })

hlc(0, "Identifier", { fg = "#EEEEEC", bg = "NONE", bold = false, italic = false })
-- @function>hlc(0, "Function", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })

hlc(0, "Statement", { fg = "#EF7DAE", bg = "NONE", bold = false, italic = false })
hlc(0, "Conditional", { fg = "#EF7DAE", bg = "NONE", bold = false, italic = false })
hlc(0, "Repeat", { fg = "#EF7DAE", bg = "NONE", bold = false, italic = false })
hlc(0, "Label", { fg = "#EF7DAE", bg = "NONE", bold = false, italic = false })
hlc(0, "Operator", { fg = "#EEEEEC", bg = "NONE", bold = false, italic = false })
hlc(0, "Keyword", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "Exception", { fg = "#EF7DAE", bg = "NONE", bold = false, italic = false })

hlc(0, "PreProc", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "Include", { fg = "#EF7DAE", bg = "NONE", bold = false, italic = false })
hlc(0, "Define", { fg = "#EF7DAE", bg = "NONE", bold = false, italic = false })
hlc(0, "Macro", { fg = "#EF7DAE", bg = "NONE", bold = true, italic = false })
hlc(0, "PreCondit", { fg = "#EF7DAE", bg = "NONE", bold = true, italic = false })

hlc(0, "Type", { fg = "#729FCF", bg = "NONE", bold = false, italic = false })
hlc(0, "StorageClass", { fg = "#EF7DAE", bg = "NONE", bold = false, italic = false })
hlc(0, "Structure", { fg = "#34E2E2", bg = "NONE", bold = false, italic = false })
hlc(0, "Typedef", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })

hlc(0, "Special", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "SpecialChar", { fg = "#FCE94F", bg = "NONE", bold = false, italic = false })
hlc(0, "Tag", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "Delimiter", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "SpecialComment", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "Debug", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })

hlc(0, "Underlined", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "MatchParen", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })

hlc(0, "Normal", { fg = "#EEEEEC", bg = "NONE", bold = false, italic = false })

hlc(0, "@function", { fg = "#EF7DAE", bg = "NONE", bold = true, italic = false })
hlc(0, "@method", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "@variable", { fg = "#A586DB", bg = "NONE", bold = false, italic = false })
hlc(0, "@parameter", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
hlc(0, "@type", { fg = "#ff0000", bg = "NONE", bold = true, italic = false })
hlc(0, "@namespace", { fg = "#19e650", bg = "NONE", bold = false, italic = false })
hlc(0, "@keyword", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
-- String>hlc(0, "@string", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })
-- Comment>hlc(0, "@comment", { fg = "#ff0000", bg = "NONE", bold = false, italic = false })



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
