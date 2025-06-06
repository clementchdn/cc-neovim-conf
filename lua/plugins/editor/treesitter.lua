return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "nvim-treesitter/nvim-treesitter-context" },
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = { "lua", "typescript", "tsx", "vim", "python" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
			-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

			highlight = {
				enable = true,
				disable = { "csv" },

				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
		})
		require("treesitter-context").setup({
			enable = false,
		})
		vim.keymap.set("n", "<leader>tsc", "<cmd>TSContextToggle<CR>", { silent = true })
		local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

		parser_configs.lua_patterns = {
			install_info = {
				url = "~/.config/nvim/parsers/nvim-treesitter-lua_patterns",
				files = { "src/parser.c" },
			},
		}
	end,
}
