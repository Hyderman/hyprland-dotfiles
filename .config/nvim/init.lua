vim.api.nvim_exec('language en_US.UTF-8', true)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
if vim.g.vscode then
    require("vscode-neovim")
else
    require("lazy").setup("plugins")
end
require("hyderman")
