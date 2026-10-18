vim.opt.updatetime = 300

vim.diagnostic.config({
  signs = false,
  underline = false,
  virtual_text = {
    spacing = 1,
    prefix = "",
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return "ERR "
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        return "WARN"
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        return "INFO"
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        return "HINT"
      end

      return ""
    end, 
  },
  float = {
    border = "rounded",
    source = "always",
  },
})

-- Clangd (C++)
vim.lsp.config["clangd"] = {
  filetypes = { "c", "cpp", },
  cmd = { "clangd", "--background-index", 
    "--clang-tidy", "--completion-style=detailed", 
    "--function-arg-placeholders=1", "--header-insertion=iwyu",
    "--header-insertion=never",
  },
  root_markers = { "compile_commands.json", ".git", "CMakeLists.txt" },
  settings = {
    clangd = {
      completion = {
        detailedLabel = true
      },
      diagnostics = {
        clangTidy = true
      }
    }
  }
}

vim.lsp.enable("clangd")


-- Quickshell (qml)
vim.lsp.config("qmlls", {
  filetypes = { "qml" },
  cmd = { "qmlls" },
  root_markers = { ".qmlls.ini", "shell.qml", ".git" },
})

vim.lsp.enable("qmlls")
