-- 定義模組表
--
-- 行為：先找指定 severity 的 diagnostic；找不到就退而找任意 severity 的。
--
-- 注意：原本用 vim.diagnostic.goto_next / goto_prev，那組在 Nvim 0.11
-- 被標記 deprecated（移除目標 1.0），改用 vim.diagnostic.jump()。
-- jump() 會回傳跳到的 diagnostic（沒找到則回 nil），所以不用再靠
-- 比對游標位置來判斷有沒有跳成功，pos_equal 就不需要了。
-- goto_next/goto_prev 預設會彈出 float，jump() 預設不會，
-- 所以這裡明確帶 float = true 維持原本的行為。
local M = {}

-- count: 1 = 往下找, -1 = 往上找
local function jump(count, opts)
    opts = opts or {}
    local severity = opts.severity or vim.diagnostic.severity.ERROR
    -- 不能寫 `opts.wrap or true`：那樣傳 false 進來也會變成 true
    local wrap = opts.wrap
    if wrap == nil then
        wrap = true
    end

    local found = vim.diagnostic.jump({
        count = count,
        severity = severity,
        wrap = wrap,
        float = true,
    })

    -- 指定的 severity 找不到，就找任意 severity 的
    if not found then
        vim.diagnostic.jump({ count = count, wrap = wrap, float = true })
    end
end

M.goto_diagnostic = function(opts)
    jump(1, opts)
end

M.goto_prev_diagnostic = function(opts)
    jump(-1, opts)
end

return M
