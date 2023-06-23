return {
    -- install without yarn or npm
    "iamcco/markdown-preview.nvim",
    config = function() 
        vim.fn["mkdp#util#install"]() 
    end
}
