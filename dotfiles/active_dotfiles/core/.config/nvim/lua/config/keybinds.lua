local map = vim.keymap.set


-- Mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- Qol
map("n", "<leader>w", ":set wrap!<CR>", { desc = "Enable/disable wordwrap" })
map("n", "<leader>L", ":Lazy<CR>", { desc = "Open Lazy.nvim" })


-- map("n", "<leader>1", "<Cmd><CR>", { desc = "Restart lsp" })
map("n", "<leader>2", "<Cmd>LspRestart<CR>", { desc = "Restart lsp" })


-- Edit files
map("n", "<leader>e", ":e ", { desc = "Insert 'e' in cmd" })


-- Exiting & saving
map("n", "<leader>q", ":q", { desc = "Insert 'q' in cmd" })
map("n", "<leader>Q", ":q!", { desc = "Insert 'q!' in cmd" })
map("n", "<leader>w", ":w", { desc = "Insert 'w' in cmd" })
map("n", "<leader>W", ":wq", { desc = "Insert 'wq' in cmd" })


-- Movement
map("n", "H", "5h", { desc = "Move 5 line left" })
map("n", "L", "5l", { desc = "Move 5 line right" })
map("n", "K", "5k", { desc = "Move 5 line up" })
map("n", "J", "5j", { desc = "Move 5 line down" })


-- Barbar
map("n", "<A-h>", "<Cmd>BufferPrevious<CR>", { desc = "Prev buffer" })
map("n", "<A-l>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })

map("n", "<leader>h", "<Cmd>BufferMovePrevious<CR>", { desc = "Move buffer back" })
map("n", "<leader>l", "<Cmd>BufferMoveNext<CR>", { desc = "Move buffer forward" })

map("n", "<leader>j", "<Cmd>BufferPin<CR>", { desc = "Pin buffer" })
map("n", "<leader>k", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })


-- Tree
map("n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })
map("n", "<leader>g", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus tree" })
map("n", "<leader>G", "<Cmd>NvimTreeFocus<CR> | :cd ./", { desc = "Focus tree and change dir" })
--map("n", "<leader>", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })

