local feline = require("feline")
local feline_vi = require("feline.providers.vi_mode")

local hl_default = {
	bg = "bg",
	fg = "fg",
}

local theme = {
	blue = "#458588",
}

local function vimode()
	return {
		provider = function()
			return string.format(" %s ", feline_vi.get_vim_mode():upper())
		end,

		hl = {
			fg = "bg",
			bg = "blue",
			style = "bold",
		},
	}
end

local function currentfile()
	return {
		provider = function()
			return string.format("%s/%s", vim.fn.expand("%:p:h:t"), vim.fn.expand("%:p:t"))
		end,
		hl = hl_default,
	}
end

local function whitespace()
	return {
		provider = " ",
		hl = hl_default,
	}
end

local function themereset()
	return {
		provider = "",
		hl = hl_default,
	}
end

feline.setup({
	components = {
		active = {
			{ -- -- LEFT -- -- 
				vimode(),
				whitespace(),
				currentfile(),
				themereset(),
			},
			{ },
			{ -- -- RIGHT -- --

			},
		},

		inactive = { { }, { }, { }, },
	},

	theme = theme,
})
