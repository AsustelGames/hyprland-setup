vim.opt.updatetime = 300

vim.keymap.set("i", "<C-k>", function()
  vim.lsp.buf.signature_help({
    border = "rounded",
    focusable = false,
  })
end, { silent = true })

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      border = "rounded",
      source = "always",
      prefix = " ",
    })
  end,
})

local M = {}

function M.setup()
  vim.diagnostic.config({
    signs = false,
    underline = true,
    virtual_text = false,
    float = {
      border = "rounded",
      source = "always",
    },
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config["clangd"] = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed", "--function-arg-placeholders=1", "--header-insertion=iwyu" },
  
    filetypes = { "c", "cpp", "cxx" },
  
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
end


return M
