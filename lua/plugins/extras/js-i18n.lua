return {
	"nabekou29/js-i18n.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		translation_source = { "**/{locales,messages}/**/*.json" },
	},
	keys = {
		{
			"<leader>tre",
			function()
				local lang = vim.fn.input("Enter language: ")
				vim.cmd("I18nEditTranslation " .. lang)
			end,
			desc = "I18n - Edits the translation at the cursor position. If there is no matching translation for the key, a new translation is added. If lang is omitted, the currently displayed language is used.",
		},
		{
			"<leader>trs",
			function()
				local lang = vim.fn.input("Enter language: ")
				vim.cmd("I18nSetLang " .. lang)
			end,
			desc = "I18n - Sets the language. The set language is used for virtual text display and definition jumps.",
		},
		{
			"<leader>trS",
			-- Function to surround the word with specified characters
			function()
				vim.notify("salut")
				-- Input mode mapping (normal mode)
				-- vim.cmd("normal! ysiwi{t('" .. vim.fn.escape("')}", "'") .. "}")
			end,

			-- Add a keybinding to execute the surround function
			desc = "I18n - Sets the language. The set language is used for virtual text display and definition jumps.",
		},
	},
}
