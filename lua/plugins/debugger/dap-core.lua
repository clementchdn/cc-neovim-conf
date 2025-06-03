return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		{
			"LiadOz/nvim-dap-repl-highlights",
			opts = function()
				require("nvim-dap-repl-highlights").setup()
				require("nvim-treesitter.configs").setup({
					highlight = {
						enable = true,
					},
					ensure_installed = { "dap_repl" },
				})
			end,
		},
	},
	keys = function()
		local dap = require("dap")
		local keys = {
			{
				"<F5>",
				function()
					dap.continue()
				end,
			},
			{
				"<F10>",
				function()
					dap.step_over()
				end,
			},
			{
				"<F11>",
				function()
					dap.step_into()
				end,
			},
			{
				"<F12>",
				function()
					dap.step_out()
				end,
			},
			{
				"<Leader>b",
				function()
					dap.toggle_breakpoint()
				end,
			},
			{
				"<Leader>ds",
				function()
					dap.close()
					require("dapui").close()
				end,
			},
			{
				"<Leader>B",
				function()
					-- Prompt the user for input
					local condition = vim.fn.input("Breakpoint condition: ")
					-- Call the toggle_breakpoint function with the user's input as a parameter
					dap.toggle_breakpoint(condition)
				end,
				{ silent = true },
			},
			{
				"<Leader>lp",
				function()
					dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
			},
			{
				"<Leader>dr",
				function()
					dap.repl.open()
				end,
			},
			{
				"<Leader>dl",
				function()
					dap.run_last()
				end,
			},
		}
		return keys
	end,
	opts = function()
		local dap = require("dap")
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = os.getenv("HOME") .. "/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		}

		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				program = "${file}",
				args = function()
					return vim.split(vim.fn.input("Arguments: "), " ")
				end,
				port = 9003,
			},
		}

		-- dap.adapters["local-lua"] = {
		-- 	type = "executable",
		-- 	command = "node",
		-- 	args = {
		-- 		os.getenv("HOME") .. "/.local/share/nvim/lazy/local-lua-debugger-vscode/extension/debugAdapter.js",
		-- 	},
		-- 	enrich_config = function(config, on_config)
		-- 		if not config["extensionPath"] then
		-- 			local c = vim.deepcopy(config)
		-- 			-- If this is missing or wrong you'll see
		-- 			-- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
		-- 			c.extensionPath = os.getenv("HOME") .. "/.local/share/nvim/lazy/local-lua-debugger-vscode/"
		-- 			on_config(c)
		-- 		else
		-- 			on_config(config)
		-- 		end
		-- 	end,
		-- }

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dap-float",
			callback = function()
				vim.api.nvim_buf_set_keymap(0, "n", "q", "<Cmd>close<CR>", { noremap = true, silent = true })
			end,
		})

		vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

		vim.fn.sign_define("DapBreakpoint", {
			text = "⬤",
			texthl = "@character.special",
			linehl = "@character.special",
			numhl = "@character.special",
		})
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "ﳁ", texthl = "@character.special", linehl = "@character.special", numhl = "@character.special" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)
	end,
	config = function() end,
}
