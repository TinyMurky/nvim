-- 定義模組表
local M = {}

M.pos_equal = function (p1, p2)
  return p1[1] == p2[1] and p1[2] == p2[2]
end

M.goto_diagnostic = function (opts)
    opts = opts or {}
    local severity = opts.severity or vim.diagnostic.severity.ERROR
    local wrap = opts.wrap or true

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.diagnostic.goto_next({ severity = severity, wrap = wrap })
    local pos2 = vim.api.nvim_win_get_cursor(0)
    if M.pos_equal(pos, pos2) then
        vim.diagnostic.goto_next({ wrap = wrap })
    end
end


M.goto_prev_diagnostic = function (opts)
    opts = opts or {}
    local severity = opts.severity or vim.diagnostic.severity.ERROR
    local wrap = opts.wrap or true

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.diagnostic.goto_prev({ severity = severity, wrap = wrap })
    local pos2 = vim.api.nvim_win_get_cursor(0)
    if M.pos_equal(pos, pos2) then
        vim.diagnostic.goto_prev({ wrap = wrap })
    end
end

return M
