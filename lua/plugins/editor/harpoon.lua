return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-lualine/lualine.nvim" },
    event = "VeryLazy",
    opts = {
        menu = {
            width = vim.api.nvim_win_get_width(0) - 4,
        },
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = true
        },
    },
    keys =
    {
        {
            "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon file"
        },
        {
            "<leader>hm",
            function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
            desc =
            "Open Harpoon Menu"
        },
        {
            "<A-h>", function() require("harpoon"):list():select(1) end
        },
        {
            "<A-j>", function() require("harpoon"):list():select(2) end
        },
        {
            "<A-k>", function() require("harpoon"):list():select(3) end
        },
        {
            "<A-l>", function() require("harpoon"):list():select(4) end
        },
        {
            "<A-m>", function() require("harpoon"):list():select(5) end
        }
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon.setup({})
        vim.api.nvim_create_autocmd('FileType', {
            pattern = "harpoon",
            callback = function()
                vim.keymap.set('n', 'q', '<cmd>wbdq<cr>', { silent = true, buffer = true })
            end,
        })
    end,
}
