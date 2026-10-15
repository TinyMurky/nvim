-- This file setup go.nvim so that go can be used
-- https://github.com/ray-x/go.nvim

return {
    {
    "ray-x/go.nvim",
    dependencies = { 
        "ray-x/guihua.lua",  -- 只需要這個是 go.nvim 特有的
        -- "neovim/nvim-lspconfig", -- 已經裝過了, lsp 要自己裝 gopls, lint 要裝golangci-lint
        -- "nvim-treesitter/nvim-treesitter", -- 已經裝過了
    },
    config = function()

        -- store in ../utils/lsp_capabilities
        local capabilities = require("utils.lsp_capabilities")
        require("go").setup({
            diagnostic = false, -- 使用init.lua內的vim.diagnostic
            golangci_lint = {
                default = 'standard', -- set to one of { 'standard', 'fast', 'all', 'none' }
                -- disable = {'errcheck', 'staticcheck'}, -- linters to disable empty by default
                enable = {'revive'}, -- linters to enable; empty by default
                config = nil,        -- set to a config file path
                no_config = false,   -- true: golangci-lint --no-config
                -- disable = {},     -- linters to disable empty by default, e.g. {'errcheck', 'staticcheck'}
                -- enable = {},      -- linters to enable; empty by default, set to e.g. {'govet', 'ineffassign','revive', 'gosimple'}
                -- enable_only = {}, -- linters to enable only; empty by default, set to e.g. {'govet', 'ineffassign','revive', 'gosimple'}
                severity = vim.diagnostic.severity.INFO, -- severity level of the diagnostics
            },
            null_ls = {    -- check null-ls integration in readme
                golangci_lint = {
                    method = {"NULL_LS_DIAGNOSTICS_ON_SAVE", "NULL_LS_DIAGNOSTICS_ON_OPEN"}, -- when it should run
                    severity = vim.diagnostic.severity.INFO, -- severity level of the diagnostics
                },
                gotest = {
                    method = {"NULL_LS_DIAGNOSTICS_ON_SAVE"}, -- when it should run
                    severity = vim.diagnostic.severity.WARN, -- severity level of the diagnostics
                },
            },
            lsp_cfg = { -- lsp auto complete
                capabilities = capabilities,
                settings = {
                    gopls = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        staticcheck = true,
                    },
                },
            },
        })

        vim.keymap.set('n', '<leader>tf', '<cmd>GoTestFunc<cr>', { desc = "Go: test current function" })
        vim.keymap.set('n', '<leader>tF', '<cmd>GoTestFile<cr>', { desc = "Go: test current file" })

        -- 存檔時自動整理 import + 格式化（gopls 官方建議的寫法）
        -- Ref: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
        --
        -- 不用 go.nvim 的 require('go.format').goimports()：
        --   它送出 organizeImports 後不等回應就讓 BufWritePre 結束，檔案先以「還沒整理 import」的內容寫入；
        --   之後 import 才套用到 buffer，而補存檔依賴 vim.lsp.buf.format 的 callback 參數，
        --   但 Neovim 0.12 的 vim.lsp.buf.format 沒有這個參數，callback 永遠不會被呼叫，
        --   結果 buffer 和硬碟內容不一致（buffer 一直是 modified），要 :e! 才看得到真正的錯誤。
        --
        -- 這裡改成在 BufWritePre 內「同步」完成 organizeImports + format，Neovim 再寫入一次，
        -- 硬碟內容 = 畫面內容，BufWritePost / didSave 也會正常觸發（revive 等 on save 的檢查會跑在最終內容上）。
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            group = format_sync_grp,
            callback = function(args)
                local client = vim.lsp.get_clients({ bufnr = args.buf, name = "gopls" })[1]
                if not client then
                    return
                end

                -- 1. organizeImports：同步等 gopls 回應後直接套用到 buffer
                --    用 args.buf 組參數（不用 make_range_params 的目前視窗），:wa 存多個檔案時也正確
                local params = {
                    textDocument = vim.lsp.util.make_text_document_params(args.buf),
                    range = {
                        start = { line = 0, character = 0 },
                        ["end"] = { line = vim.api.nvim_buf_line_count(args.buf), character = 0 },
                    },
                    context = { only = { "source.organizeImports" }, diagnostics = {} },
                }
                local resp = client:request_sync("textDocument/codeAction", params, 3000, args.buf)
                for _, action in ipairs(resp and resp.result or {}) do
                    -- client 支援 resolve 時，server 可能延後提供 edit，需要再 resolve 一次
                    if not action.edit and action.data then
                        local resolved = client:request_sync("codeAction/resolve", action, 3000, args.buf)
                        action = resolved and resolved.result or action
                    end
                    if action.edit then
                        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
                    end
                end

                -- 2. 格式化（gofmt）：同步
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, async = false, timeout_ms = 3000 })
            end,
        })

    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- 安裝 go-tools
    }
}
