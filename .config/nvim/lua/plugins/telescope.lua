return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope")
        local telescopeConfig = require("telescope.config")

        -- Clone the default Telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")
        telescope.setup({
            defaults = {
                -- `hidden = true` is not supported in text grep commands.
                vimgrep_arguments = vimgrep_arguments,
            },
            pickers = {
                find_files = {
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
        })
    end,
    keys = {
        { '<leader>gf', "<cmd>Telescope git_files<CR>",  desc = 'Search [G]it [F]iles' },
        { '<leader>sf', "<cmd>Telescope find_files<CR>", desc = '[S]earch [F]iles' },
        { '<leader>sr', "<cmd>Telescope lsp_references<CR>", desc = '[S]earch [R]eferences' },
        { '<leader>sh', "<cmd>Telescope help_tags<CR>",  desc = '[S]earch [H]elp' },
        { '<leader>sw', "<cmd>Telescope grep_string<CR>", desc = '[S]earch current [W]ord' },
        { '<leader>sg', "<cmd>Telescope live_grep<CR>",   desc = '[S]earch by [G]rep' },
        { '<leader>sd', "<cmd>Telescope diagnostics<CR>", desc = '[S]earch [D]iagnostics' },
        { '<leader>ss', "<cmd>Telescope lsp_document_symbols<CR>", desc = "[S]earch [S]ymbols" },
        { '<leader>sS', "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "[S]earch [S]ymbols" },
    }
}
