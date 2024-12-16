-- all key binding related config

-- leader key set to space
vim.g.mapleader = " "

vim.keymap.set('i', 'kj', '<esc>', { desc = "Escape" })


-- set clipboard with wl-clipboard install
-- use +p for paste
-- +y for
vim.cmd("set clipboard+=unnamedplus")
vim.keymap.set('v', '<leader>y', '"+y', { desc = "Copy from clipboard" })
vim.keymap.set('n', '<leader>p', '"+p', { desc = "Paste from clipboard" })

-- Tab setting
-- code inside vim.cmd to change setting of neovim
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- line number in the left
vim.wo.relativenumber = true

