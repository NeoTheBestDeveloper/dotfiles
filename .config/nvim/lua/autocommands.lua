-- autocmd! remove all autocommands, if entered under a group it will clear that group
vim.cmd([[
    autocmd BufWritePre *.py,*.lua,*.c,*.cpp,*.hs,*.html,*.css,*.js,*.rs,*.h execute "lua vim.lsp.buf.formatting_sync()"
    autocmd BufWritePost Xresources silent !{xrdb -merge %}
    autocmd BufWritePost ~/.config/sxhkd/sxhkdrc silent !{pkill sxhkd; sxhkd &; disown} 
    autocmd FileType htmldjango silent :set filetype=html
]])



-- augroup _general_settings
--     autocmd!
--     autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
--     autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})
--     autocmd BufWinEnter * :set formatoptions-=cro
--     autocmd FileType qf set nobuflisted
-- augroup end
--
-- augroup _auto_resize
--     autocmd!
--     autocmd VimResized * tabdo wincmd =
-- augroup end
--
-- augroup _alpha
--     autocmd!
--     autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
-- augroup end
