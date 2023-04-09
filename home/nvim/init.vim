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

:aug rc_diagnostics
  au!
  au ModeChanged *:n lua vim.diagnostic.show()
  au TextYankPost * lua vim.diagnostic.reset()
  au ModeChanged *:i lua vim.diagnostic.reset()
  au CursorHold * lua vim.diagnostic.open_float()
:aug END

colorscheme gruvbox
hi Pmenu guibg=#303030
hi DiagnosticError guifg=#ff4934

lua require("pluginconfig.rust-tools")
lua require("pluginconfig.feline")

" instant.nvim
let g:instant_username = "fetch"

" context.nvim
let g:context_max_height = 3
let g:context_max_per_indent = 1
let g:context_max_join_parts = 1

if exists('g:neovide')
  set guifont=monospace:h16
end
