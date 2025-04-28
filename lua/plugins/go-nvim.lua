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
            lsp_inlay_hints = {
                enable = true, -- this is the only field apply to neovim > 0.10
            },
        })

        -- 下面這個是存檔的時候自動排成go
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require('go.format').goimports()
            end,
            group = format_sync_grp,
        })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- 安裝 go-tools
    }
}
