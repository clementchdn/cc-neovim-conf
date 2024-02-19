require('transparent').setup()

vim.keymap.set("n", "<leader>t",
  function()
    require('transparent').toggle()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#9999ee", blend = 50 })
  end
)
