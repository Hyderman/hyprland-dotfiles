vim.opt.nu = true
-- vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.cmd('autocmd BufEnter * set formatoptions-=ro') -- Autocomment neovim
vim.cmd('autocmd BufEnter * setlocal formatoptions-=ro')
vim.api.nvim_command("set cinoptions+=N-s") -- Namespace indent
