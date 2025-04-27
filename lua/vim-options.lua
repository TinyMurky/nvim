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

-- jump  between error
local error_jump = require("utils.error_jump")

vim.keymap.set("n", "]e", function() error_jump.goto_diagnostic({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Jump to next error" })
vim.keymap.set("n", "]w", function() error_jump.goto_diagnostic({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Jump to next warning" })


vim.keymap.set("n", "[e", function() error_jump.goto_prev_diagnostic({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Jump to previous error" })
vim.keymap.set("n", "[w", function() error_jump.goto_prev_diagnostic({ severity = vim.diagnostic.severity.WARN }) end, { desc = "Jump to previous warning" })

-- line number in the left
vim.wo.relativenumber = true

-- 和vim.diagnose一起用, 彈出錯誤訊息
vim.keymap.set('n', '<leader>i', function()
    -- If we find a floating window, close it.
    local found_float = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative ~= '' then
            vim.api.nvim_win_close(win, true)
            found_float = true
        end
    end

    if found_float then
        return
    end

    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
end, { desc = 'Toggle Diagnostics' })