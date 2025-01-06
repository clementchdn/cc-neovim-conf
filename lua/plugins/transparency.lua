return {
	"xiyaowong/transparent.nvim",
	opts = {
		-- table: default groups
		groups = {
			"Normal",
			"NormalNC",
			"Comment",
			"Constant",
			"Special",
			"Identifier",
			"Statement",
			"PreProc",
			"Type",
			"Underlined",
			"Todo",
			"String",
			"Function",
			"Conditional",
			"Repeat",
			"Operator",
			"Structure",
			"LineNr",
			"NonText",
			"SignColumn",
			"CursorLine",
			"CursorLineNr",
			"StatusLine",
			"StatusLineNC",
			"EndOfBuffer",
		},
		-- table: additional groups that should be cleared
		extra_groups = {},
		-- table: groups you don't want to clear
		exclude_groups = {},
		-- function: code to be executed after highlight groups are cleared
		-- Also the user event "TransparentClear" will be triggered
		on_clear = function() end,
	},
}
-- vim.keymap.set("n", "<leader>t", function()
-- 	if vim.g.transparent_enabled then
-- 		vim.api.nvim_set_hl(0, "LineNr", { fg = "#9999ee", blend = 100 })
-- 	else
-- 		vim.api.nvim_set_hl(0, "LineNr", { fg = "#9999ee", blend = 50 })
-- 	end
-- 	require("transparent").toggle()
-- end)
