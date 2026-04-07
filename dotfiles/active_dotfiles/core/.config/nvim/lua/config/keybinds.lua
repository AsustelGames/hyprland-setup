local map = vim.keymap.set

-- Mapleader
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Barbar
map("n", "<A-h>", "<Cmd>BufferPrevious<CR>", { desc = "Prev buffer" })
map("n", "<A-l>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })

map("n", "<leader>h", "<Cmd>BufferMovePrevious<CR>", { desc = "Move buffer back" })
map("n", "<leader>l", "<Cmd>BufferMoveNext<CR>", { desc = "Move buffer forward" })

map("n", "<leader>j", "<Cmd>BufferPin<CR>", { desc = "Pin buffer" })
map("n", "<leader>k", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })

