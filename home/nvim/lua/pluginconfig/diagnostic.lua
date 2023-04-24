local sev = vim.diagnostic.severity

vim.diagnostic.config({
	underline = {
		severity = { sev.ERROR, sev.WARN },
	},

	virtual_text = {
		severity = sev.ERROR,
		source = false,
	},

	float = {
		scope = "cursor",
		severity_sort = true,
		source = false,
	},

	signs = false,
	update_in_insert = false,
	severity_sort = true,
})
