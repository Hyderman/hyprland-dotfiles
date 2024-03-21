-- undo/REDO via vscode
-- vim.keymap.set("n","u","<Cmd>call VSCodeNotify('undo')<CR>")
-- vim.keymap.set("n","<C-r>","<Cmd>call VSCodeNotify('redo')<CR>"vim.opt.clipboard = "unnamedplus"

vim.keymap.set('n', '<C-/>', "<Cmd>call VSCodeNotifyVisual('editor.action.commentLine', 1)<CR>", { noremap = true })
vim.keymap.set('x', '<C-/>', "<Cmd>call VSCodeNotifyVisual('editor.action.commentLine', 1)<CR>", { noremap = true })

vim.keymap.set('n', '<esc>', ':noh<return><esc>', { noremap = true })

vim.keymap.set('n', 'u', "<Cmd>call VSCodeNotify('undo')<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<C-r>', "<Cmd>call VSCodeNotify('redo')<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '<C-j>', "m`:silent +g/\\m^\\s*$/d<CR>``:noh<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', "m`:silent -g/\\m^\\s*$/d<CR>``:noh<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', ":set paste<CR>m`o<Esc>``:set nopaste<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ":set paste<CR>m`O<Esc>``:set nopaste<CR>", { noremap = true, silent = true })
vim.keymap.set('x', 'p', "p:let @+=@0<CR>:let @\"=@0<CR>", { noremap = true, silent = true })
vim.keymap.set('n', 'gp', "<Cmd>call VSCodeNotify('editor.action.marker.next')<CR>",
    { noremap = true, silent = true })
vim.keymap.set('n', 'gP', "<Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>",
    { noremap = true, silent = true })
