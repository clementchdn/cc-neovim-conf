return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "LiadOz/nvim-dap-repl-highlights",
    },
    config = function()
        local dap, dapui, dap_virtual_text, dap_widgets = require("dap"), require("dapui"),
            require("nvim-dap-virtual-text"), require("dap.ui.widgets")

        dapui.setup()
        dap_virtual_text.setup()

        require("nvim-dap-repl-highlights").setup()
        require("dap-go").setup()

        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = os.getenv("HOME") .. "/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
        }

        -- dapui
        dapui.setup(
            {
                layouts = { {
                    elements = { {
                        id = "scopes",
                        size = 0.25
                    }, {
                        id = "breakpoints",
                        size = 0.25
                    }, {
                        id = "stacks",
                        size = 0.25
                    }, {
                        id = "watches",
                        size = 0.25
                    } },
                    position = "left",
                    size = 40
                }, {
                    elements = { {
                        id = "repl",
                        size = 0.5
                    }, {
                        id = "console",
                        size = 0.5
                    } },
                    position = "top",
                    size = 10
                } }
            }
        )

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end


        -- keymap
        vim.keymap.set("n", "<F5>", function()
            dap.continue()
        end)
        vim.keymap.set("n", "<F10>", function()
            dap.step_over()
        end)
        vim.keymap.set("n", "<F11>", function()
            dap.step_into()
        end)
        vim.keymap.set("n", "<F12>", function()
            dap.step_out()
        end)
        vim.keymap.set("n", "<Leader>b", function()
            dap.toggle_breakpoint()
        end)
        vim.keymap.set("n", "<Leader>ds", function()
            dap.close()
            dapui.close()
        end)

        vim.keymap.set("n", "<Leader>B", function()
            -- Prompt the user for input
            local condition = vim.fn.input('Breakpoint condition: ')
            -- Call the toggle_breakpoint function with the user's input as a parameter
            dap.toggle_breakpoint(condition)
        end, { silent = true })

        vim.keymap.set("n", "<Leader>lp", function()
            dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end)
        vim.keymap.set("n", "<Leader>dr", function()
            dap.repl.open()
        end)
        vim.keymap.set("n", "<Leader>dl", function()
            dap.run_last()
        end)
        vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
            dap_widgets.hover()
        end)
        vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
            dap_widgets.preview()
        end)
        vim.keymap.set("n", "<Leader>df", function()
            dap_widgets.centered_float(dap_widgets.frames)
        end)

        vim.keymap.set("n", "<Leader>do", function()
            dapui.open()
        end)
        vim.keymap.set("n", "<Leader>dc", function()
            dapui.close()
        end)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'dap-float',
            callback = function()
                vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<Cmd>close<CR>', { noremap = true, silent = true })
            end,
        })

        vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
        vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

        vim.fn.sign_define('DapBreakpoint', {
            text = '',
            texthl = '@character.special',
            linehl = '@character.special',
            numhl =
            '@character.special'
        })
        vim.fn.sign_define('DapBreakpointCondition',
            { text = 'ﳁ', texthl = '@character.special', linehl = '@character.special', numhl = '@character.special' })
        vim.fn.sign_define('DapBreakpointRejected',
            { text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
        vim.fn.sign_define('DapLogPoint',
            { text = '', texthl = 'DapLogPoint', linehl = 'DapLogPoint', numhl = 'DapLogPoint' })
        vim.fn.sign_define('DapStopped',
            { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
    end,
}
