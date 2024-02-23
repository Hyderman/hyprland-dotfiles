return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            {
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            -- { "dcampos/nvim-snippy" },
            { "L3MON4D3/LuaSnip" },

            { "p00f/clangd_extensions.nvim" },
        },
        -- 0.10 neovim feature
        -- opts = {
        --     inlay_hints = { enabled = true },
        -- },
        config = function()
            vim.keymap.set("n", "gh", "<cmd>ClangdSwitchSourceHeader<CR>", { silent = true, noremap = true })
            vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action({apply = true})<CR>",
                { noremap = true, silent = true })
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                lsp_zero.buffer_autoformat()
                require("clangd_extensions.inlay_hints").setup_autocmd()
                require("clangd_extensions.inlay_hints").set_inlay_hints()
            end)

            local cmp = require('cmp')
            local cmp_format = require('lsp-zero').cmp_format()

            cmp.setup({
                formatting = cmp_format,
            })

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
            local luasnip = require("luasnip")
            luasnip.config.set_config({
                region_check_events = 'InsertEnter',
                delete_check_events = 'InsertLeave'
            })
            -- local snippy = require("snippy")

            cmp.setup({
                -- REQUIRED - you must specify a snippet engine
                -- snippet = {
                --     expand = function(args)
                --         require('snippy').expand_snippet(args.body) -- For `snippy` users.
                --     end,
                -- },
                mapping = {
                    -- ['<Tab>'] = cmp_action.luasnip_supertab(),
                    -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                    ['<C-f>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        -- if cmp.visible() then
                        --     cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.recently_used,
                        require("clangd_extensions.cmp_scores"),
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },

            })

            require('mason-lspconfig').setup({
                ensure_intalled = {
                    "clangd",
                    "lua_ls",
                    "neocmake",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })

            --Enable (broadcasting) snippet capability for completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            require("lspconfig").html.setup {
                capabilities = capabilities,
            }

            require("lspconfig").clangd.setup {
                cmd = {
                    "clangd",
                    "--query-driver=**",
                    "--function-arg-placeholders=true"
                }
            }
            --     -- Custom LSP setup for clangd
            local function custom_clangd_setup()
                require("lspconfig").clangd.setup {
                    cmd = {
                        "clangd",
                        "--query-driver=**",
                        "--function-arg-placeholders=true",
                        "--clang-tidy=false" -- Disable clang-tidy
                    }
                }
            end

            -- Toggle between default and custom LSP setups for clangd
            local clangd_custom = false

            function toggle_clangd_setup()
                vim.lsp.stop_client(vim.lsp.get_active_clients())
                if clangd_custom then
                    -- Activate default setup
                    require("lspconfig").clangd.setup {
                        cmd = {
                            "clangd",
                            "--query-driver=**",
                            "--function-arg-placeholders=true",
                        }
                    }
                    clangd_custom = false
                else
                    -- Activate custom setup
                    custom_clangd_setup()
                    clangd_custom = true
                end
            end

            -- Key mapping to toggle LSP setup for clangd
            vim.api.nvim_set_keymap('n', '<Leader>c', ':lua toggle_clangd_setup()<CR>', { noremap = true, silent = true })
        end
    }
}
