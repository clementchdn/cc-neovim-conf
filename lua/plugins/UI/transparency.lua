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
		-- table: groups you don't want to clear
		exclude_groups = {},
		-- function: code to be executed after highlight groups are cleared
		-- Also the user event "TransparentClear" will be triggered
		on_clear = function() end,
	},
	config = function()
		vim.keymap.set("n", "<leader>tt", function()
			-- Toggle the transparency with the transparent.nvim plugin
			require("transparent").toggle()

			-- Update LineNr color based on transparency
			if vim.g.transparent_enabled then
				vim.api.nvim_set_hl(0, "LineNr", { fg = "#9999ee", blend = 100 })
			else
				vim.api.nvim_set_hl(0, "LineNr", { fg = "#9999ee", blend = 50 })
			end

			-- Get the background color from the current theme (assuming it's catppuccin or other theme)
			local current_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg

			print(current_bg)
			local current_bg_hex = "#000000"
			if current_bg ~= nil then
				-- Convert the color to a proper hex string if it's available
				current_bg_hex = string.format("#%06x", current_bg)
			end

			-- Update lualine background transparency based on the transparency state
			if vim.g.transparent_enabled then
				-- Set lualine background to transparent
				vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = NONE })
				vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = NONE })
				vim.api.nvim_set_hl(0, "lualine_x_normal", { bg = NONE })
				vim.api.nvim_set_hl(0, "lualine_y_normal", { bg = NONE })
				vim.api.nvim_set_hl(0, "lualine_z_normal", { bg = NONE })
				vim.api.nvim_set_hl(0, "TabLineFill", { bg = NONE })
			else
				-- Set lualine background to current theme's background color (catppuccin or others)
				vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = current_bg_hex })
				vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = current_bg_hex })
				vim.api.nvim_set_hl(0, "lualine_x_normal", { bg = current_bg_hex })
				vim.api.nvim_set_hl(0, "lualine_y_normal", { bg = current_bg_hex })
				vim.api.nvim_set_hl(0, "lualine_z_normal", { bg = current_bg_hex })
				vim.api.nvim_set_hl(0, "TabLineFill", { bg = current_bg_hex })
			end
		end)
	end,
}
