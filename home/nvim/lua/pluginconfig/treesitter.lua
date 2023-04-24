local ts_configs = require("nvim-treesitter.configs")

local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

ts_configs.setup({
	ensure_installed = { "rust", "c", "lua", "nix" },
  	parser_install_dir = parser_install_dir,
	highlight = {
		additional_vim_regex_highlighting = false,
		enable = true,
	},

	incremental_selection = {
		enable = true,
	},

	indent = {
		enable = true,
	},
})
