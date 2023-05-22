local sev = vim.diagnostic.severity

vim.diagnostic.config({
	underline = {
		severity = assert(sev.ERROR),
	},

	virtual_text = false,

	float = {
		scope = "cursor",
		severity_sort = true,
		source = false,
	},

	signs = false,
	severity_sort = true,
})
