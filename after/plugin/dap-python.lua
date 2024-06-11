require('dap-python').setup('/home/clement/MyWell/mywell-back/debugpy/bin/python3.12')

function _G.get_pytest_name()
  local oldpos = vim.fn.getpos('.')
  vim.fn.search('def test', 'cbnW')
  local test_line = vim.fn.getline('.')
  local test_name = test_line:match('def ([^%(]+)')
  vim.fn.setpos('.', oldpos)
  print(test_name)
  return test_name
end

table.insert(require('dap').configurations.python, {
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
    "--log-file=test_out.log"
  },
  console = "integratedTerminal"
}
)

table.insert(require('dap').configurations.python, {
  name = "Pytest: Current Test",
  type = "python",
  request = "launch",
  module = "pytest",
  env = {
    ENVIRONMENT = "test",
  },
  args = function()
    local test_name = _G.get_pytest_name()
    return {
      "${file} -k " .. test_name,
      "-sv",
      "--log-cli-level=INFO",
      "--log-file=test_out.log"
    }
  end,
  console = "integratedTerminal",
})
