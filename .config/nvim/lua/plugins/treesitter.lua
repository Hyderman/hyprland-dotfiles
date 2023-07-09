return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag"
	},
	build = ":TSUpdate",
	config = function()
		require 'nvim-treesitter.configs'.setup {
		-- A list of parser names, or "all" (the five listed parsers should always be installed)
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "cpp", "cmake", "python", "make" },

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		-- List of parsers to ignore installing (for "all")
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},

        autotag = {
            enable = true,
        }
	}
end
}
