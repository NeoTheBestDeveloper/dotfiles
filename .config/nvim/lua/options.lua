-- Options. --

-- Enable mouse. --
vim.opt.mouse = "a"

-- Enable numbers. --
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable swapfile.
vim.opt.swapfile = false

-- Enable ignore case and hls. --
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.hls = true

-- Setup tabs.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.filetype = "plugin"
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

-- Enable more colors. --
vim.opt.termguicolors = true

-- Enable clipboard. --
vim.opt.clipboard = "unnamedplus"

-- Setup encoding. --
vim.opt.fileencoding = "utf-8"

-- More flush buffer to file.
vim.opt.updatetime = 300

vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 3
vim.opt.concealcursor = "niv"
vim.opt.hidden = true
vim.opt.showmode = false
