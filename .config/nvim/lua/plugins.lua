local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return require("packer").startup(function()
    -- UI
    use("nvim-lualine/lualine.nvim") -- Beatiful airline written on lua
    use("shaunsingh/nord.nvim") -- Colorschemes
    use "moll/vim-bbye"
    use "akinsho/bufferline.nvim"
    use("kyazdani42/nvim-web-devicons") -- Icons for nvim.
    use("norcalli/nvim-colorizer.lua") -- Css colors
    use("lewis6991/gitsigns.nvim") -- Git
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }) -- Treesitter
    use("p00f/nvim-ts-rainbow") -- Rainbow brackets with treesitter.
    use('junegunn/goyo.vim') -- Zen mode
    use({ 'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Startup window.
    use('folke/todo-comments.nvim') -- Comments highlight.
    use('karb94/neoscroll.nvim') -- Smooth scroll.

    -- Comletion
    use("hrsh7th/nvim-cmp") -- The completion plugin
    use("hrsh7th/cmp-buffer") -- buffer completions
    use("hrsh7th/cmp-path") -- path completions
    use("hrsh7th/cmp-cmdline") -- cmdline completions
    use("saadparwaiz1/cmp_luasnip") -- snippet completions


    -- Snippets
    use({ "L3MON4D3/LuaSnip" }) --snippet engine
    use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use


    -- LSP
    use({ "neovim/nvim-lspconfig" }) -- enable LSP
    use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
    use({ "hrsh7th/cmp-nvim-lsp" }) -- completion with lsp
    use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
    use("ray-x/lsp_signature.nvim") -- Highlight function signatures.


    -- Tools
    use("lewis6991/impatient.nvim") -- Enable caching
    use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" }) -- Telescope
    use("nvim-telescope/telescope-media-files.nvim") -- Support media view in telescope.
    use {
        "nvim-neo-tree/neo-tree.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker",
        }
    }
    use("wbthomason/packer.nvim") -- Packer can manage itself
    use("akinsho/toggleterm.nvim") -- Terminal in nvim.
    use("simrat39/symbols-outline.nvim")
    use("ahmedkhalf/project.nvim") -- Project managment.


    -- Lang
    use("JoosepAlviste/nvim-ts-context-commentstring") -- Easily comment stuff
    use("numToStr/Comment.nvim") --  Easily comment stuff
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    }) -- Makrkdown preview.
    use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
    use("windwp/nvim-ts-autotag") -- Auto html tags.
    use("lukas-reineke/cmp-under-comparator") -- Better autocomplete sorting.

    if packer_bootstrap then
        require("packer").sync()
    end
end)
