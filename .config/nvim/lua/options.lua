-- Global options.
local opt = vim.opt

-- Enable mouse.
opt.mouse = "a"

-- Enable number for rows.
opt.number = true
opt.relativenumber = true

-- Disable swapfile
opt.swapfile = false

-- Some usefull settings for searching.
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
opt.hls = false

-- Setup tabs.
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.filetype = "plugin"
opt.sidescrolloff = 8
opt.scrolloff = 8

-- Enable full colors support.
opt.termguicolors = true

-- Enable clipboard.
opt.clipboard = "unnamedplus"

-- Setup encoding. --
opt.fileencoding = "utf-8"

opt.spelllang = { "en_us", "ru" }
opt.completeopt = { "menuone", "noselect" }

opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 3
opt.concealcursor = "nv"
opt.hidden = true
opt.showmode = false
opt.spelllang = { "en_us", "ru" }

opt.updatetime = 50

-- Set colorscheme.
vim.cmd("colorscheme catppuccin")
