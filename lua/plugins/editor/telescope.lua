return {
	"nvim-telescope/telescope.nvim",
	-- or                            , branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/noice.nvim",
		"aaronhallaert/advanced-git-search.nvim",
	},
	opts = {
		defaults = {
			file_ignore_patterns = { "node_modules", "dist", "build", ".git", ".venv" },
			extensions = {
				advanced_git_search = {
					-- Browse command to open commits in browser. Default fugitive GBrowse.
					browse_command = "GBrowse",
					-- fugitive or diffview
					diff_plugin = "fugitive",
					-- customize git in previewer
					-- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
					git_flags = {},
					-- customize git diff in previewer
					-- e.g. flags such as { "--raw" }
					git_diff_flags = {},
					-- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
					show_builtin_git_pickers = false,
					entry_default_author_or_date = "author", -- one of "author" or "date"
					keymaps = {
						-- following keymaps can be overridden
						toggle_date_author = "<C-w>",
						open_commit_in_browser = "<C-o>",
						copy_commit_hash = "<C-y>",
						show_entire_commit = "<C-e>",
					},

					-- Telescope layout setup
					telescope_theme = {
						function_name_1 = {
							-- Theme options
						},
						function_name_2 = "dropdown",
						-- e.g. realistic example
						show_custom_functions = {
							layout_config = { width = 0.4, height = 0.4 },
						},
					},
				},
			},
		},
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files({ hidden = true, unrestricted = true })
		end, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>pS", function()
			builtin.lsp_workspace_symbols()
		end)
		vim.keymap.set("n", "<leader>vrr", builtin.lsp_references, {})
		vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>")

		require("telescope").load_extension("noice")
		require("telescope").load_extension("advanced_git_search")
		vim.keymap.set("n", "<leader>ph", "<CMD>Telescope advanced_git_search diff_commit_file<CR>")
		vim.keymap.set("n", "<leader>pda", function() builtin.diagnostics({ bufnr = 0 }) end)
		vim.keymap.set("n", "<leader>pdA", builtin.diagnostics)
	end,
}
