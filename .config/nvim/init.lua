-- Nvim configurations. --
-- nvim

-- Include configs.

require("plugins")
require("setup")
require("keymap")
require("options")
require("autocommands")
require("lsp")
vim.cmd([[source $HOME/.config/nvim/todo.vim]])
