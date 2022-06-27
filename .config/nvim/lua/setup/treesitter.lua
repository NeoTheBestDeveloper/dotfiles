local configs = require("nvim-treesitter.configs")
configs.setup({
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
        -- disable = { "markdown" }
    },
    autopairs = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    indent = { enable = true, disable = { "python", "yaml" } },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = true,
    },
})
