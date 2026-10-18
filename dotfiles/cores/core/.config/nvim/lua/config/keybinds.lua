local map = vim.keymap.set


-- Mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- Qol
map("n", "<leader>L", ":Lazy<CR>", { desc = "Open Lazy.nvim" })
map("n", "<Leader>H", "<cmd>nohlsearch<CR>", { desc = "clear highlight" })
map("n", "<leader>e", ":e ", { desc = "Insert 'e' in cmd" })
map("n", "<Leader>d", vim.diagnostic.open_float, { desc = "Show diagnostics" })


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

map("n", "j", "gj")
map("n", "k", "gk")


-- Barbar
map("n", "<A-h>", "<Cmd>BufferPrevious<CR>", { desc = "Prev buffer" })
map("n", "<A-l>", "<Cmd>BufferNext<CR>", { desc = "Next buffer" })

map("n", "<leader>h", "<Cmd>BufferMovePrevious<CR>", { desc = "Move buffer back" })
map("n", "<leader>l", "<Cmd>BufferMoveNext<CR>", { desc = "Move buffer forward" })

map("n", "<leader>j", "<Cmd>BufferPin<CR>", { desc = "Pin buffer" })
map("n", "<leader>k", "<Cmd>BufferClose<CR>", { desc = "Close buffer" })


-- Tree
map("n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle tree" })
map("n", "<leader>g", "<Cmd>NvimTreeFocus<CR> | :cd ", { desc = "Focus tree and change dir" })


-- Blink.cmp (plugins.autocomplete)
-- Insert mode
-- ["<Enter>"] = { "accept", "fallback" },
-- ["<S-Tab>"] = { "accept", "fallback" },
-- ["<M-k>"] = { "select_prev", "fallback" },
-- ["<M-j>"] = { "select_next", "fallback" },

-- Cmdline
-- ["<Enter>"] = { "accept", "fallback" },


-- Copying and Pasting
map("n", "<Leader>c", 'ggVG"+y<C-o>', { desc = "Copy whole file and return to the original position" })
map("n", "<C-c>", '"+yy', { desc = "Copy line to clipboard" })
map("v", "<C-c>", '"+y', { desc = "Copy from clipboard" })
map("n", "<C-v>", '"+p', { desc = "Paste line from clipboard" })


-- Unbinding stuff
vim.opt.mouse = "a"
local mouse_keys = {
  "<LeftMouse>",
  "<2-LeftMouse>",
  "<3-LeftMouse>",
  "<LeftDrag>",
  "<LeftRelease>",
  
  "<MiddleMouse>",
  "<2-MiddleMouse>",
  "<3-MiddleMouse>",
  "<MiddleDrag>",
  "<MiddleRelease>",

  "<RightMouse>",
  "<2-RightMouse>",
  "<3-RightMouse>",
  "<RightDrag>",
  "<RightRelease>",

  "<ScrollWheelUp>",
  "<ScrollWheelDown>",
  "<ScrollWheelLeft>",
  "<ScrollWheelRight>",

  "<Up>",
  "<Down>",
  "<Left>",
  "<Right>",
}

for _, key in ipairs(mouse_keys) do
  vim.keymap.set({ "n", "i", "v" }, key, "<Nop>")
end
