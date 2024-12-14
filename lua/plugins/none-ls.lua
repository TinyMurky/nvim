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
            sources = {
                -- remember to download it with `:Mason` => find formmatter => find stylua, press `i` to install
                null_ls.builtins.formatting.stylua,

                -- TypeScript
                null_ls.builtins.formatting.prettier,
                -- require("none-ls.diagnostics.eslint"),

                -- Python
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
            },
        })

        -- space + f for format
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, {})
    end,
}
