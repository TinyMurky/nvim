-- 定義模組表
local M = {}

M.pos_equal = function (p1, p2)
  local r1, c1 = table.unpack(p1)
  local r2, c2 = table.unpack(p2)
  return r1 == r2 and c1 == c2
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
