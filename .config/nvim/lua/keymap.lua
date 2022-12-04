-- Hotkeys.o
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader key.
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.vim_markdown_folding_disabled = 1

-- Follow link.
keymap("n", "<leader>o", "$T(yt) | :!open -b <cr><cr>", opts)


-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-q>", "<C-w>q", opts)

-- Resize window with arrows.
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Open nvim-tree.
keymap("n", "<leader>n", ":Neotree toggle<CR>", opts)

-- Navigate buffers --
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprev<CR>", opts)
keymap("n", "<S-q>", ":Bdelete<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Markdown preview.
keymap("n", "<leader>P", ":MarkdownPreviewToggle<CR>", opts)

-- Fix indenting visual block.
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down.
keymap("v", "p", "_dP", opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Telescope keymaps.
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>s", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>t", "<cmd>TodoTelescope<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope projects<cr>", opts)

-- Toggle term keymaps.
keymap("n", "<leader>h", ":lua _HTOP_TOGGLE()<cr>", opts)
keymap("n", "<leader>g", ":lua _LAZYGIT_TOGGLE()<cr>", opts)

-- Analise code tree.
keymap("n", "<leader>a", "<cmd>SymbolsOutline<cr>", opts)
