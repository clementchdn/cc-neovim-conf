require('dap-python').setup('/home/clement/MyWell/mywell-back/debugpy/bin/python3.12')
-- require("dap-python").setup("/usr/bin/python")
--
-- table.insert(require("dap").configurations.python, {
--     type = "python",
--     request = "launch",
--     name = "Module",
--     console = "integratedTerminal",
--     module = "naas_core", -- edit this to be your app's main module
--     cwd = "${workspaceFolder}",
-- })


table.insert(require('dap').configurations.python, {
  {
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
    console = "integratedTerminal",
  },
})
