return {
    "mfussenegger/nvim-dap",

    dependencies = {

        -- fancy UI for the debugger
        {
            "rcarriga/nvim-dap-ui",
            -- stylua: ignore
            keys = {
                { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
                { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
            },
            opts = {},
            config = function(_, opts)
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup(opts)
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open({})
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close({})
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close({})
                end
                dapui.setup {
                    -- set icons to characters that are more likely to work in every terminal.
                    --    feel free to remove or use ones that you like more! :)
                    --    don't feel like these are good choices.
                    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                    controls = {
                        element = "repl",
                        enabled = true,
                        icons = {
                            disconnect = "",
                            pause = "",
                            play = "",
                            run_last = "",
                            step_back = "",
                            step_into = "",
                            step_out = "",
                            step_over = "",
                            terminate = ""
                        },
                    },
                }

            end,
        },

        -- virtual text for the debugger
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },


        -- mason.nvim integration
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_installation = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},

                -- You'll need to check that you have the required things installed
                -- online, please don't ask me how to install them :)
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                    "codelldb",
                    "python",
                },
            },
        },
    },

    -- stylua: ignore
    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<leader>dr", function() require("dap").restart() end, desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },

    config = function()
        vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
        vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })

        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakPoint' })
        vim.fn.sign_define('DapBreakPointCondition', { text = '', texthl = 'DapBreakPoint' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakPoint' })
        vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogpoint' })
        vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped' })

        local finders = require("telescope.finders")
        local pickers = require("telescope.pickers")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        local dap = require('dap')
        dap.configurations.cpp = {
            {
                name = "Launch an executable",
                type = "codelldb",
                request = "launch",
                cwd = "${workspaceFolder}",
                program = function()
                    return coroutine.create(function(coro)
                        local opts = {}
                        pickers
                        .new(opts, {
                            prompt_title = "Path to executable",
                            finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                            sorter = conf.generic_sorter(opts),
                            attach_mappings = function(buffer_number)
                                actions.select_default:replace(function()
                                    actions.close(buffer_number)
                                    coroutine.resume(coro, action_state.get_selected_entry()[1])
                                end)
                                return true
                            end,
                        })
                        :find()
                    end)
                end,
            },
        }
        dap.configurations.c = dap.configurations.cpp
    end,
}
