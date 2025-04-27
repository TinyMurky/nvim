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
        require("go").setup()

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