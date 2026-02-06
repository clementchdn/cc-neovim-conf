local M = {}

local C = require("catppuccin.palettes").get_palette(flavour)

M.transparent = {
	normal = {
		a = { fg = C.mantle, bg = C.blue, gui = "bold" },
		b = { fg = C.blue, bg = C.surface0 },
		c = { bg = transparent_bg, fg = C.text },
	},
	insert = {
		a = { bg = C.green, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.green },
	},

	terminal = {
		a = { bg = C.green, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.green },
	},

	command = {
		a = { bg = C.peach, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.peach },
	},
	visual = {
		a = { bg = C.mauve, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.mauve },
	},
	replace = {
		a = { bg = C.red, fg = C.base, gui = "bold" },
		b = { bg = C.surface0, fg = C.red },
	},
	inactive = {
		a = { bg = transparent_bg, fg = C.blue },
		b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
		c = { bg = transparent_bg, fg = C.overlay0 },
	},
	tabline = {
		a = { fg = "#89b4fa", bg = "NONE", gui = "bold" },
		b = { fg = "#cdd6f4", bg = "NONE" },
		c = { fg = "#a6adc8", bg = "NONE" },
		z = { fg = "#89b4fa", bg = "NONE" },
	},
}

-- example non-transparent theme
M.solid = "auto" -- or "tokyonight", "catppuccin", etc.

return M
