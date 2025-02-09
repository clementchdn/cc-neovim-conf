return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "marilari88/neotest-vitest",
        { "alfaix/neotest-gtest", opts = {} }
    },
    opts = {
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
    },
    keys = function()
        local test_args = {
            -- strategy = "dap",
            env = { ENVIRONMENT = "test" },
            extra_args = {
                "-sv",
                "--log-cli-level=INFO",
                "--log-file=test_out.log",
            },
        }
        local keys = {
            -- open tests output
            {
                "<Leader>to",
                function()
                    require("neotest").output.open({ enter = true })
                end,
                desc = "open tests output"
            },
            -- open tests summary
            {
                "<A-n>", "<CMD>Neotest summary toggle<CR>", desc = "open tests summary"
            },
            -- stop running tests
            {
                "<leader>ts", "<CMD>Neotest stop<CR>", desc = "stop running tests"
            },
            -- run all tests in app/tests
            {
                "<leader>ta",
                function()
                    local filetype = vim.bo.filetype
                    local tests_path = ""
                    if filetype == "python" then
                        tests_path = vim.fn.expand(vim.fn.getcwd() .. "/app/tests/")
                    elseif
                        filetype == "typescript"
                        or filetype == "javascript"
                        or filetype == "typescriptreact"
                        or filetype == "javascriptreact"
                    then
                        tests_path = vim.fn.expand(vim.fn.getcwd() .. "/src/**/__tests__/*")
                    end
                    require("neotest").run.run({
                        tests_path,
                        -- strategy = "dap",
                        env = { ENVIRONMENT = "test" },
                        extra_args = {
                            "-sv",
                            "--log-cli-level=INFO",
                            "--log-file=test_out.log",
                        },
                    })
                end,
                desc = "run all tests in app/tests"
            },
            {
                -- run all tests in current file
                "<leader>tf",
                function()
                    require("neotest").run.run({
                        vim.fn.expand("%"),
                        -- strategy = "dap",
                        env = { ENVIRONMENT = "test" },
                        extra_args = {
                            "-sv",
                            "--log-cli-level=INFO",
                            "--log-file=test_out.log",
                        },
                    })
                end,
                desc = "run all tests in current file"
            },
            -- run closest test
            {
                "<leader>td", function() require("neotest").run.run(test_args) end, desc = "run closest test"

            },
            --run marked (from summary)
            {
                "<leader>tm",
                function()
                    require("neotest").summary.run_marked(test_args)
                end,
                desc = "run marked (from summary)"
            }
        }
        return keys
    end,
    config = function()
        require("neotest").setup({
            adapters = {
                ["neotest-python"] = {
                    args = { "-sv" }, -- get more diff
                    runner = "pytest",
                    dap = {
                        console = "integratedTerminal",
                        -- redirectOutput = true,
                    },
                },
                ["neotest-vitest"] = {
                    filter_dir = function(name)
                        return name ~= "node_modules"
                    end,
                },
                require("neotest-gtest").setup({
                    debug_adapter = "cppdbg",
                    -- Add the path to your test executables if needed
                    discover_root = function()
                        return vim.fn.getcwd() -- Change this if necessary
                    end,
                }),
            }
        })
    end
}
