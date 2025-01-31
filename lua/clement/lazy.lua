local plugins = {
    -- unused themes
    -- "olimorris/onedarkpro.nvim",
    -- {
    -- 	"eldritch-theme/eldritch.nvim",
    -- 	lazy = false,
    -- 	priority = 1000,
    -- 	opts = {},
    -- },
    -- { "rose-pine/neovim", name = "rose-pine" },

    --[[ {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }--]]
    -- UI

    --  {
    --   'nvimdev/dashboard-nvim',
    --   event = 'VimEnter',
    --   config = function()
    --     require('dashboard').setup {
    --       -- config
    --     }
    --   end,
    --   dependencies = { 'nvim-tree/nvim-web-devicons' }
    -- }
    -- {
    -- 	"zbirenbaum/copilot.lua",
    -- 	cmd = "Copilot",
    -- 	event = "InsertEnter",
    -- 	config = function()
    -- 		require("copilot").setup({
    -- 			suggestion = {
    -- 				enabled = true,
    -- 				auto_trigger = true,
    -- 				debounce = 75,
    -- 				keymap = {
    -- 					accept = "<M-l>",
    -- 					accept_word = false,
    -- 					accept_line = false,
    -- 					next = "<M-]>",
    -- 					prev = "<M-[>",
    -- 					dismiss = "<C-]>",
    -- 				},
    -- 			},
    -- 		})
    -- 	end,
    -- },
    --
    -- {
    -- 	"CopilotC-Nvim/CopilotChat.nvim",
    -- 	branch = "canary",
    -- 	dependencies = {
    -- 		{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    -- 		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    -- 	},
    -- 	opts = {
    -- 		debug = true, -- Enable debugging
    -- 		-- See Configuration section for rest
    -- 	},
    -- 	-- See Commands section for default commands if you want to lazy load on them
    -- },

    "ThePrimeagen/vim-be-good",

    -- hardtime
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {
            max_count = 50,
            disabled_keys = {
                ["<Up>"] = { "" },
                ["<Down>"] = { "" },
                ["<Left>"] = { "" },
                ["<Right>"] = { "" },
            },
        },
    },

    {
        "doctorfree/cheatsheet.nvim",
        event = "VeryLazy",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            local ctactions = require("cheatsheet.telescope.actions")
            require("cheatsheet").setup({
                bundled_cheetsheets = {
                    enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
                    disabled = { "nerd-fonts" },
                },
                bundled_plugin_cheatsheets = {
                    enabled = {
                        "auto-session",
                        "goto-preview",
                        "octo.nvim",
                        "telescope.nvim",
                        "vim-easy-align",
                        "vim-sandwich",
                    },
                    disabled = { "gitsigns" },
                },
                include_only_installed_plugins = true,
                telescope_mappings = {
                    ["<CR>"] = ctactions.select_or_fill_commandline,
                    ["<A-CR>"] = ctactions.select_or_execute,
                    ["<C-Y>"] = ctactions.copy_cheat_value,
                    -- ["<C-E>"] = ctactions.edit_user_cheatsheet,
                },
            })
        end,
    },
    {
        "chrishrb/gx.nvim",
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,      -- default settings
        submodules = false, -- not needed, submodules are required only for tests

        -- you can specify also another config if you want
        config = function()
            require("gx").setup({
                open_browser_app = "xdg-open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
                open_browser_args = { "" },    -- specify any arguments, such as --background for macOS' "open".
                handlers = {
                    plugin = true,             -- open plugin links in lua (e.g. packer, lazy, ..)
                    github = true,             -- open github issues
                    brewfile = true,           -- open Homebrew formulaes and casks
                    package_json = true,       -- open dependencies from package.json
                    search = true,             -- search the web/selection on the web if nothing else is found
                    go = true,                 -- open pkg.go.dev from an import statement (uses treesitter)
                    jira = {                   -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
                        name = "jira",         -- set name of handler
                        handle = function(mode, line, _)
                            local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
                            if ticket and #ticket < 20 then
                                return "http://jira.company.com/browse/" .. ticket
                            end
                        end,
                    },
                    rust = {                     -- custom handler to open rust's cargo packages
                        name = "rust",           -- set name of handler
                        filetype = { "toml" },   -- you can also set the required filetype for this handler
                        filename = "Cargo.toml", -- or the necessary filename
                        handle = function(mode, line, _)
                            local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

                            if crate then
                                return "https://crates.io/crates/" .. crate
                            end
                        end,
                    },
                },
                handler_options = {
                    search_engine = "google",                             -- you can select between google, bing, duckduckgo, ecosia and yandex
                    search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
                    select_for_search = false,                            -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link

                    git_remotes = { "upstream", "origin" },               -- list of git remotes to search for git issue linking, in priority
                    git_remotes = function(fname)                         -- you can also pass in a function
                        if fname:match("myproject") then
                            return { "mygit" }
                        end
                        return { "upstream", "origin" }
                    end,

                    git_remote_push = false,          -- use the push url for git issue linking,
                    git_remote_push = function(fname) -- you can also pass in a function
                        return fname:match("myproject")
                    end,
                },
            })
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    -- {                                        -- optional completion source for require statements and module annotations
    --   "hrsh7th/nvim-cmp",
    --   opts = function(_, opts)
    --     opts.sources = opts.sources or {}
    --     table.insert(opts.sources, {
    --       name = "lazydev",
    --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    --     })
    --   end,
    -- },
    -- Lua
    {
        "Zeioth/dooku.nvim",
        event = "VeryLazy",
        opts = {
            -- your config options here
        },
    },
    -- cppman
    {
        "madskjeldgaard/cppman.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },

        config = function()
            local cppman = require("cppman")
            cppman.setup()

            -- Make a keymap to open the word under cursor in CPPman
            vim.keymap.set("n", "<leader>cm", function()
                cppman.open_cppman_for(vim.fn.expand("<cword>"))
            end)

            -- Open search box
            vim.keymap.set("n", "<leader>cc", function()
                cppman.input()
            end)
        end,
    },
}

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins.UI" },
        { import = "plugins.debugger" },
        { import = "plugins.coding" },
        { import = "plugins.editor" },
        { import = "plugins.extras" },
        { import = "plugins.git" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

-- it seems that nvim-surround.setup() must be called after loading other plugins for it to work
require("nvim-surround").setup()
