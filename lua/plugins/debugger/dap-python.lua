return {
	"mfussenegger/nvim-dap-python",
	enabled = false,
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local path = vim.fn.getcwd()
		require("dap-python").setup(path .. "/.venv/bin/python")

		function _G.get_pytest_name()
			local oldpos = vim.fn.getpos(".")
			vim.fn.search("def test", "cbnW")
			local test_line = vim.fn.getline(".")
			local test_name = test_line:match("def ([^%(]+)")
			vim.fn.setpos(".", oldpos)
			return test_name
		end

		table.insert(require("dap").configurations.python, {
			name = "Current python file",
			cwd = "${workspaceFolder}",
			type = "python",
			request = "launch",
			program = "${file}",
			env = {
				ENVIRONMENT = "test",
			},
			args = function()
				return vim.split(vim.fn.input("Arguments: "), " ") -- Prompt for args
			end,
			console = "integratedTerminal",
		})

		table.insert(require("dap").configurations.python, {
			name = "Pytest: Current Module",
			cwd = "${workspaceFolder}",
			type = "python",
			request = "launch",
			module = "pytest",
			env = {
				ENVIRONMENT = "test",
			},
			args = {
				"${workspaceFolder}",
				"-sv",
				"--log-cli-level=INFO",
				"--log-file=test_out.log",
			},
			console = "integratedTerminal",
		})

		table.insert(require("dap").configurations.python, {
			name = "Pytest: Current File",
			cwd = "${workspaceFolder}",
			type = "python",
			request = "launch",
			module = "pytest",
			env = {
				ENVIRONMENT = "test",
			},
			args = {
				"${file}",
				"-sv",
				"--log-cli-level=INFO",
				"--log-file=test_out.log",
			},
			console = "integratedTerminal",
		})

		table.insert(require("dap").configurations.python, {
			name = "Pytest: Current Test",
			type = "python",
			request = "launch",
			module = "pytest",
			env = {
				ENVIRONMENT = "test",
			},
			args = function()
				local test_name = _G.get_pytest_name()
				vim.notify("salut" .. test_name)
				return {
					"${file} -k " .. test_name,
					"-sv",
					"--log-cli-level=INFO",
					"--log-file=test_out.log",
				}
			end,
			console = "integratedTerminal",
		})
	end,
}
