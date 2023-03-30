set relativenumber
set autoindent

colorscheme gruvbox

lua require("pluginconfig.rust-tools")

if exists("g:neovide")
	set guifont=monospace:h16
end
