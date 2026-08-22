-- all key binding related config

-- leader key set to space
vim.g.mapleader = " "

-- vim.keymap.set('i', 'kj', '<esc>', { desc = "Escape" })


-- set clipboard with wl-clipboard install
-- use +p for paste
-- +y for
vim.cmd("set clipboard+=unnamedplus")
vim.keymap.set('v', '<leader>y', '"+y', { desc = "Copy from clipboard" })
vim.keymap.set('n', '<leader>p', '"+p', { desc = "Paste from clipboard" })

-- Tab setting
-- code inside vim.cmd to change setting of neovim
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- jump  between error
local error_jump = require("utils.error_jump")

vim.keymap.set("n", "]e", function() error_jump.goto_diagnostic({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Jump to next error" })
vim.keymap.set("n", "]w", function() error_jump.goto_diagnostic({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Jump to next warning" })


vim.keymap.set("n", "[e", function() error_jump.goto_prev_diagnostic({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Jump to previous error" })
vim.keymap.set("n", "[w", function() error_jump.goto_prev_diagnostic({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Jump to previous warning" })

-- 主動打開inlay hint
vim.keymap.set('n', '<leader>H',
    function()
    	if vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }) then
    		vim.lsp.inlay_hint.enable(false, { bufnr = 0 })
    	else
    		vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
    	end
    end
)

-- 左側顯示絕對行號
vim.wo.number = true
vim.wo.relativenumber = false

-- 顯示游標所在行的 LSP 診斷訊息。
-- `scope = "line"` 比 `cursor` 寬鬆：游標不必剛好停在被標記的字元上。
vim.keymap.set('n', '<leader>i', function()
    vim.diagnostic.open_float(nil, { focus = false, scope = 'line' })
end, { desc = 'Show line diagnostics' })
