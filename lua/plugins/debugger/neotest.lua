return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"marilari88/neotest-vitest",
		{ "alfaix/neotest-gtest", opts = {} },
	},
	opts = {
		output = {
			-- disable pop-up with failing test info (prefer virtual text)
			enabled = true,
			open_on_run = false,
		},
		output_panel = {
			-- open output panel automatically
			enabled = true,
			open = "top split | resize 15",
		},
		quickfix = {
			enabled = false,
			open = false,
		},
	},
	keys = function()
		local test_args = {
			strategy = "dap",
			env = { ENVIRONMENT = "test" },
			extra_args = {
				"-sv",
				"--log-cli-level=INFO",
				"--log-file=test_out.log",
			},
		}
		local keys = {
			-- open tests output
			{
				"<Leader>to",
				function()
					require("neotest").output.open({ enter = true })
				end,
				desc = "open tests output",
			},
			-- open tests summary
			{
				"<A-n>",
				"<CMD>Neotest summary toggle<CR>",
				desc = "open tests summary",
			},
			-- stop running tests
			{
				"<leader>ts",
				"<CMD>Neotest stop<CR>",
				desc = "stop running tests",
			},
			-- run all tests in app/tests
			{
				"<leader>ta",
				function()
					local filetype = vim.bo.filetype
					local tests_path = ""
					if filetype == "python" then
						tests_path = vim.fn.expand(vim.fn.getcwd() .. "/app/tests/")
					elseif
						filetype == "typescript"
						or filetype == "javascript"
						or filetype == "typescriptreact"
						or filetype == "javascriptreact"
					then
						tests_path = vim.fn.expand(vim.fn.getcwd() .. "/src/**/__tests__/*")
					end
					require("neotest").run.run({
						tests_path,
						-- strategy = "dap",
						env = { ENVIRONMENT = "test" },
						extra_args = {
							"-sv",
							"--log-cli-level=INFO",
							"--log-file=test_out.log",
						},
					})
				end,
				desc = "run all tests in app/tests",
			},
			{
				-- run all tests in current file
				"<leader>tf",
				function()
					require("neotest").run.run({
						vim.fn.expand("%"),
						-- strategy = "dap",
						env = { ENVIRONMENT = "test" },
						extra_args = {
							"-sv",
							"--log-cli-level=INFO",
							"--log-file=test_out.log",
						},
					})
				end,
				desc = "run all tests in current file",
			},
			-- run closest test
			{
				"<leader>td",
				function()
					local ft = vim.bo.filetype
					if ft == "java" then
						require("neotest").run.run()
					else
						require("neotest").run.run({
							vim.fn.expand("%"),
							strategy = "dap",
						})
					end
				end,
				desc = "run closest test",
			},
			--run marked (from summary)
			{
				"<leader>tm",
				function()
					require("neotest").summary.run_marked()
				end,
				desc = "run marked (from summary)",
			},
		}
		return keys
	end,
	config = function()
		local lib = require("neotest.lib")
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					-- Extra arguments for nvim-dap configuation
					-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
					dap = { justMyCode = false },
					-- Command line arguments for runner
					-- Can also be a function to return dynamic values
					args = { "--log-level", "DEBUG" },
					-- Runner to use. Will use pytest if available by default.
					-- Can be a function to return dynamic value.
					runner = "pytest",
					-- Custom python path for the runner.
					-- Can be a string or a list of strings.
					-- Can also be a function to return dynamic value.
					-- If not provided, the path will be inferred by checking for
					-- virtual envs in the local directory and for Pipenev/Poetry configs
					python = ".venv/bin/python",
					-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
					-- instances for files containing a parametrize mark (default: false)
					pytest_discover_instances = true,
				}),
				require("neotest-java")({
					dap = { justMyCode = false },
					runner = "maven",
					-- optional java-specific config
					-- default works fine
				}),
				require("neotest-gtest").setup({
					debug_adapter = "cppdbg",
					-- Add the path to your test executables if needed
					root = lib.files.match_root_pattern("compile_commands.json", ".clangd", ".git"),
					-- discover_root = function()
					-- 	return vim.fn.getcwd() -- Change this if necessary
					-- end,
				}),
				["neotest-vitest"] = {
					filter_dir = function(name)
						return name ~= "node_modules"
					end,
				},
			},
		})
		-- },
	end,
}
