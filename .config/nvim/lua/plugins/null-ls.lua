return {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {
        ensure_installed = {
            "black",
            "isort",
        },
    },
    config = function()
        local null_ls = require("null-ls")
        local sources = {
            -- python
            null_ls.builtins.formatting.black.with({
                extra_args = { "--line-length=88" }
            }),
            null_ls.builtins.formatting.isort,
        }

        null_ls.setup({ sources = sources })
    end
}
