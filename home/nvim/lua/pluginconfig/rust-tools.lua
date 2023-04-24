local rt = require("rust-tools")

rt.setup({
	tools = {
		inlay_hints = {
			auto = true,
			only_current_line = true,
		},

		hover_actions = {
			
		},
	},
	server = {
		on_attach = function(_, bufnr)
		end,
	}
})
