return {
    -- NOTE: Yes, you can install new plugins here!
    "mfussenegger/nvim-dap",
    -- NOTE: And you can specify dependencies as well
    dependencies = {
        -- Creates a beautiful debugger UI
        "rcarriga/nvim-dap-ui",

        -- Installs the debug adapters for you
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        -- Add your own debuggers here
    },
    config = function()
        local dap = require "dap"
        local dapui = require "dapui"

        require("mason-nvim-dap").setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You"ll need to check that you have the required things installed
            -- online, please don"t ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                "codelldb",
                "python"
            },
        }

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set("n", "<F5>", dap.continue)
        vim.keymap.set("n", "<F11>", dap.step_into)
        vim.keymap.set("n", "<F10>", dap.step_over)
        vim.keymap.set("n", "<S-F11>", dap.step_out)
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end)

        -- Dap UI setup
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
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
        -- toggle to see last session result. Without this ,you can"t see session output in case of unhandled exception.
        vim.keymap.set("n", "<F7>", dapui.toggle)
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

    end,
}
