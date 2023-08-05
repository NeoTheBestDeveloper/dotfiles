-- Setup coloscheme.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})

vim.g.nord_disable_background = true
vim.g.nord_borders = true
vim.g.nord_italic = false
require("nord").set()
