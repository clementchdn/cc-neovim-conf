local plugins = {
  {
    "folke/noice.nvim",
    dependencies = { {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to  the notification view.
      --   If not available, we  `mini` as the fallback
      "rcarriga/nvim-notify",
    } }
  },

  'olimorris/onedarkpro.nvim',
  { "catppuccin/nvim",                 name = "catppuccin" },

  'xiyaowong/transparent.nvim',

  {
    'nvim-telescope/telescope.nvim',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  'nvim-treesitter/playground',
  'theprimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function()
      require('git-conflict').setup()
    end
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig',            lazy = { format = { timeout_ms = 3000 } } },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  'eandrju/cellular-automaton.nvim',

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to  `main` branch for the latest features
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },

  --[[ {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }--]]
  -- nvim-dap for debuggging
  'mfussenegger/nvim-dap',
  'mfussenegger/nvim-dap-python',
  { "rcarriga/nvim-dap-ui",     dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },

  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    'cameron-wags/rainbow_csv.nvim',
    config = function()
      require 'rainbow_csv'.setup()
    end,
    -- optional lazy-loading below
    -- module = {
    --   'rainbow_csv',
    --   'rainbow_csv.fns'
    -- },
    ft = {
      'csv',
      'tsv',
      'csv_semicolon',
      'csv_whitespace',
      'csv_pipe',
      'rfc_csv',
      'rfc_semicolon'
    }
  },

  -- d to format code with prettier, black, etc
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup()
    end,
  },

  -- color picker
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  },
  { "NvChad/nvim-colorizer.lua" },

  -- UI
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },

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

  'christoomey/vim-tmux-navigator',

  'github/copilot.vim',

  'CopilotC-Nvim/CopilotChat.nvim',

  'RRethy/vim-illuminate',

  'nvim-pack/nvim-spectre',

  'stevearc/oil.nvim',

  'ggandor/leap.nvim',

  'NStefan002/2048.nvim',

  'ThePrimeagen/vim-be-good',

  'ray-x/go.nvim',
  'ray-x/guihua.lua', -- recommended if need floating window support
  { "mistricky/codesnap.nvim", build = "make" },
  -- hardtime
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      max_count = 10,
      disabled_keys = {
        ["<Up>"] = { "" },
        ["<Down>"] = { "" },
        ["<Left>"] = { "" },
        ["<Right>"] = { "" },
      },
    }
  },
  -- neoscroll for smooth ctrl-D and ctrl-U
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup {}
    end
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    cmd = { "AdvancedGitSearch" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- optional: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      -- "sindrets/diffview.nvim",
    },
  }
}

require("lazy").setup(plugins, {})
