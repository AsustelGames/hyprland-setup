local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
  on_attach = function(client, bufnr)
    -- optional keymaps
    local buf_map = function(mode, lhs, rhs)
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap=true, silent=true })
    end
    buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  end
})

-- semantic highlights
vim.cmd([[
  highlight LspSemanticFunction guifg=#FF5555
  highlight LspSemanticMethod   guifg=#FF5555
  highlight LspSemanticVariable guifg=#FFFFFF
  highlight LspSemanticParameter guifg=#AAAAAA
  highlight LspSemanticType     guifg=#19e650
]])
