-- vim.cmd('colorscheme onedark')
-- require('onedarkpro').setup({
--   options = {
--     transparency = true,
--     cursorline = true
--   }
-- })
-- require('onedarkpro').load()
return {
	"catppuccin/nvim",
	name = "catppuccin",
	opts = {
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		-- background = {       -- :h background
		--   light = "latte",
		--   dark = "mocha",
		-- },
		transparent_background = true, -- disables setting the background color.
		show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
		term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
			enabled = false, -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15, -- percentage of the shade to apply to the inactive window
		},
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		no_underline = false, -- Force no underline
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" }, -- Change the style of comments
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		color_overrides = {
			mocha = {
				base = "#000000",
				mantle = "#000000",
				crust = "#000000",
			},
		},
		-- custom_highlights = {},
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = true,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
			dap = true,
			dap_ui = true,
			neotest = true,
			gitgraph = true,
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	},
	config = function()
		-- require("catppuccin").setup({
		-- 	color_overrides = {
		-- 		mocha = {
		-- 			base = "#000000",
		-- 			mantle = "#000000",
		-- 			crust = "#000000",
		-- 		},
		-- 	},
		-- })

		-- setup must be called before loading
		vim.cmd.colorscheme("catppuccin")

		vim.api.nvim_set_hl(0, "Cursor", { fg = "#999999", bg = "#999999" })
		vim.api.nvim_set_hl(0, "CursorReset", { fg = "white", bg = "white" })

		local catppuccin = require("catppuccin.palettes").get_palette("mocha")

		-- Commit Information Highlight Groups
		vim.api.nvim_set_hl(0, "GitGraphHash", { fg = catppuccin.teal, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphTimestamp", { fg = catppuccin.peach, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphAuthor", { fg = catppuccin.green, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphBranchName", { fg = catppuccin.red, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphBranchTag", { fg = catppuccin.lavender, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphBranchMsg", { fg = catppuccin.text, bg = "NONE" })

		-- Branch Colors Highlight Groups
		vim.api.nvim_set_hl(0, "GitGraphBranch1", { fg = catppuccin.blue, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphBranch2", { fg = catppuccin.red, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphBranch3", { fg = catppuccin.green, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphBranch4", { fg = catppuccin.yellow, bg = "NONE" })
		vim.api.nvim_set_hl(0, "GitGraphBranch5", { fg = catppuccin.pink, bg = "NONE" })
	end,
}
