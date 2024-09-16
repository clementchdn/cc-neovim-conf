local xmake_component = {
	function()
		local xmake = require("xmake.project").info
		if xmake.target.tg == "" then
			return ""
		end
		return xmake.target.tg .. "(" .. xmake.mode .. ")"
	end,

	cond = function()
		return vim.o.columns > 100
	end,

	on_click = function()
		require("xmake.project._menu").init() -- Add the on-click ui
	end,
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_w = { xmake_component },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {
			"location",
			{
				function()
					local starts = vim.fn.line("v")
					local ends = vim.fn.line(".")
					local count = starts <= ends and ends - starts + 1 or starts - ends + 1
					return count .. "V"
				end,
				cond = function()
					return vim.fn.mode():find("[Vv]") ~= nil
				end,
			},
		},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
