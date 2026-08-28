-- Config linter and formatter
-- https://github.com/nvimtools/none-ls.nvim
-- https://www.youtube.com/watch?v=SxuwQJ0JHMU&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=4

return {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim", -- for eslint
    },
    config = function()
        local null_ls = require("null-ls") -- none-ls is call null-ls

        null_ls.setup({
            -- debug 模式會持續寫入 null-ls.log；平常關閉，避免 log 無限制成長並拖慢 Neovim。
            -- 只有在排查 none-ls 問題、需要詳細 generator 輸出時才暫時改回 true。
            debug = false,
            sources = {
                -- remember to download it with `:Mason` => find formmatter => find stylua, press `i` to install
                null_ls.builtins.formatting.stylua,

                -- TypeScript
                null_ls.builtins.formatting.prettier,
                -- require("none-ls.diagnostics.eslint"),

                -- Python
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,

                -- Go
                -- Ref: https://github.com/ray-x/go.nvim?tab=readme-ov-file#integrate-null-ls
                null_ls.builtins.diagnostics.revive.with({
                    diagnostics_postprocess = function(diagnostic)
                        -- revive 遇到 Go 語法錯誤時，偶爾會回傳 End=(0, 0)，
                        -- 造成 diagnostic 終點早於起點；Neovim 0.12 會因此在
                        -- vim.diagnostic.set() 報「Failed to adjust diagnostic position」。
                        -- 將反向 range 收斂成起點後的一個字元，保留警告並避免崩潰。
                        local range_is_reversed = diagnostic.end_lnum < diagnostic.lnum
                            or (diagnostic.end_lnum == diagnostic.lnum and diagnostic.end_col < diagnostic.col)

                        if range_is_reversed then
                            diagnostic.end_lnum = diagnostic.lnum
                            diagnostic.end_col = diagnostic.col + 1
                        end
                    end,
                }),

            },
        })

        -- space + f for format
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, {})

        -- auto format Python on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.py",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })

        -- auto format Rust on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.rs",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
}
