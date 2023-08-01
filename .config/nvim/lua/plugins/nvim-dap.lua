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
                    "cppdbg",
                    "python",
                },
            },
        },
    },

    -- stylua: ignore
    keys = {
        { "<leader>B", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dd", function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" },
        { "<F5>", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>dc", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
        { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<F23>", function() require("dap").step_out() end, desc = "Step Out" },
        { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        { "<F17>", function() require("dap").terminate() end, desc = "Terminate" },
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

        local dap = require('dap')
        dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                    setupCommands = {
                        {
                            text = '-enable-pretty-printing',
                            description =  'enable pretty printing',
                            ignoreFailures = false
                        },
                        {
                            description = "Set Disassembly Flavor to Intel",
                            text = "-gdb-set disassembly-flavor intel",
                            ignoreFailures = true
                        }
                    },
                },
        }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
        -- dap.adapters.lldb = dap.adapters.codelldb
        require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { "c", "cpp" } })
    end,
}
