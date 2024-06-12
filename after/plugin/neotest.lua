require("neotest").setup({
  adapters = {
    require("neotest-python")({
      args = { "-sv" }, -- get more diff
      runner = "pytest",
      dap = {
        console = "integratedTerminal",
        -- redirectOutput = true,
      }
    }),
    require("neotest-vitest")({
      filter_dir = function(name, rel_path, root)
        return name ~= "node_modules"
      end,
    }),
  },
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
})


local test_args = {
  strategy = "dap",
  env = { ENVIRONMENT = "test" },
  extra_args = {
    "-sv",
    "--log-cli-level=INFO",
    "--log-file=test_out.log"
  }
}

-- open tests output
vim.keymap.set("n", "<Leader>to", function() require("neotest").output.open({ enter = true }) end)
-- open tests summary
vim.keymap.set("n", "<A-n>", "<CMD>Neotest summary toggle<CR>")
-- stop running tests
vim.keymap.set("n", "<leader>ts", "<CMD>Neotest stop<CR>")
-- run all tests in app/tests
vim.keymap.set("n", "<leader>ta",
  function()
    require("neotest").run.run({
      vim.fn.expand(vim.fn.getcwd() .. "/app/tests/"),
      strategy = "dap",
      env = { ENVIRONMENT = "test" },
      extra_args = {
        "-sv",
        "--log-cli-level=INFO",
        "--log-file=test_out.log"
      }
    })
  end)
-- run all tests in current file
vim.keymap.set("n", "<leader>tf",
  function()
    require("neotest").run.run({
      vim.fn.expand("%"),
      strategy = "dap",
      env = { ENVIRONMENT = "test" },
      extra_args = {
        "-sv",
        "--log-cli-level=INFO",
        "--log-file=test_out.log"
      }
    })
  end)
-- run closest test
vim.keymap.set("n", "<leader>td",
  function() require("neotest").run.run(test_args) end)

--run marked (from summary)
vim.keymap.set("n", "<leader>tm", function() require("neotest").summary.run_marked(test_args) end)
