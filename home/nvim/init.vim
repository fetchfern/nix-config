set number
set relativenumber
set autoindent
set undofile
set termguicolors
set shortmess+=c
set nowrap
set noshowmode
set laststatus=3
set signcolumn=no
set nowritebackup
set mouse=nvia
set updatetime=300

let mapleader=' '

nnoremap <silent><leader>wv <cmd>vsplit<CR>
nnoremap <silent><leader>wh <cmd>split<CR>
nnoremap <silent><leader>h <C-w>h
nnoremap <silent><leader>j <C-w>j
nnoremap <silent><leader>k <C-w>k
nnoremap <silent><leader>l <C-w>l

aug rc_diagnostics
  au!
  au ModeChanged *:n lua pcall(vim.diagnostic.show)
  au TextYankPost * lua vim.diagnostic.reset(); vim.diagnostic.hide()
  au ModeChanged *:i lua vim.diagnostic.reset(); vim.diagnostic.hide()
aug END

nnoremap <silent><C-i> <cmd>lua vim.diagnostic.open_float()<CR>

" instant.nvim
let g:instant_username = "fetch"

" context.nvim
let g:context_max_height = 3
let g:context_max_per_indent = 1
let g:context_max_join_parts = 1

" coq.nvim
let g:coq_settings = {
  \ 'auto_start': 'shut-up',
  \ 'display.pum.fast_close': v:false,
  \ 'display.icons.mode': 'none',
  \ 'display.pum.kind_context': [ '', '' ],
  \ 'display.pum.source_context': [ '', '' ],
  \ 'display.ghost_text.enabled': v:false,
  \ 'xdg': v:true,
  \ }

lua require("pluginconfig.rust-tools")
lua require("pluginconfig.feline")
lua require("pluginconfig.treesitter")
lua require("coq")

colorscheme nightfox

hi Normal guibg=#00000000
hi NormalNC guibg=#00000000
hi WinSeparator guibg=#00000000
hi Pmenu guibg=#303030
hi DiagnosticError guifg=#ff4934

if exists('g:neovide')
  set guifont=monospace:h16
end
