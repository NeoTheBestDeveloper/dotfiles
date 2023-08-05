local lsp_installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

local servers = { "pyright", "lua_ls", 'clangd', 'html', 'emmet_ls', 'jsonls', 'cssls', 'grammarly', 'tailwindcss',
    'yamlls', 'asm_lsp', 'rust_analyzer', 'tailwindcss', 'tsserver', 'flow' }

lsp_installer.setup {
    ensure_installed = servers
}

local function on_attach(client, buffer)
    require("lsp.handlers").on_attach(client, buffer)
end

for _, server in pairs(servers) do
    local opts = {
        on_attach = on_attach,
        capabilities = require("lsp.handlers").capabilities,
    }
    local has_custom_opts, server_custom_opts = pcall(require, "lsp.settings." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
    end
    lspconfig[server].setup(opts)
end
