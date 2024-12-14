-- all key binding related config

-- leader key set to space
vim.g.mapleader = " "

vim.keymap.set('i', 'kj', '<esc>', { desc = "Escape" })


-- set clipboard with wl-clipboard install
-- use +p for paste
-- +y for
vim.cmd("set clipboard+=unnamedplus")
vim.keymap.set('v', '<C-c>', '"+y', { desc = "Copy from clipboard" })
vim.keymap.set('n', '<C-v>', '"+p', { desc = "Paste from clipboard" })

-- Tab setting
-- code inside vim.cmd to change setting of neovim
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- line number in the left
vim.wo.relativenumber = true

