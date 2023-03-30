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

let mapleader=' '

nnoremap <silent><leader>wv <cmd>vsplit<CR>
nnoremap <silent><leader>wh <cmd>split<CR>
nnoremap <silent><leader>h <C-w>h
nnoremap <silent><leader>j <C-w>j
nnoremap <silent><leader>k <C-w>k
nnoremap <silent><leader>l <C-w>l

colorscheme gruvbox
hi Pmenu guibg=#303030
hi DiagnosticError guifg=#ff4934

lua require("pluginconfig.rust-tools")
lua require("pluginconfig.feline")

if exists("g:neovide")
	set guifont=monospace:h16
end
