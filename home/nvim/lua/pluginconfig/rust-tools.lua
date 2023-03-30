local rt = require("rust-tools")

rt.setup({
	tools = {
		inlay_hints = { auto = false },
	},
	server = {
		on_attach = function(_, bufnr)
		end,
	}
})
