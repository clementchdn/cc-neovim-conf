require("neotest").setup({
  adapters = {
    require("neotest-python")({
      args = { "-v" }, -- get more diff
      runner = "pytest",
    }),
  },
  output = {
    -- disable pop-up with failing test info (prefer virtual text)
    open_on_run = false,
  },
  quickfix = {
    enabled = false,
  },
})
vim.keymap.set("n", "<A-n>", "<CMD>Neotest summary toggle<CR>")
vim.keymap.set("n", "<leader>tn", "<CMD>Neotest run<CR>")
vim.keymap.set("n", "<leader>ts", "<CMD>Neotest stop<CR>")
vim.keymap.set("n", "<leader>tf",
  function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap", env = { ENVIRONMENT = "test" } }) end)
vim.keymap.set("n", "<leader>td",
  function() require("neotest").run.run({ strategy = "dap", env = { ENVIRONMENT = "test" } }) end)
