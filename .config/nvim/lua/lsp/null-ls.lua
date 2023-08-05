local null_ls_status_ok, null_ls = pcall(require, "null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions


null_ls.setup({
    debug = false,
    sources = {
        formatting.black,
        formatting.djlint.with({ extra_filetypes = { 'html' } }),
        diagnostics.djlint.with({ extra_filetypes = { 'html' } }),
        formatting.clang_format,
        diagnostics.ruff,
        diagnostics.pylint,
        diagnostics.mypy,
        diagnostics.eslint_d,
        diagnostics.cppcheck,
        code_actions.refactoring,
        on_attach = function(client, bufnr)
            if client.server_capabilities.documentFormattingProvider then
                local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
                vim.api.nvim_create_autocmd(
                    "BufWritePre",
                    { buffer = bufnr, callback = vim.lsp.buf.format, group = group }
                )
            end
        end,
    },
})
