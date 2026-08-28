-- 在 Herdr panes 與 Neovim splits 之間無縫導覽與調整大小。
-- https://github.com/lmilojevicc/herdr-splits.nvim
return {
    "lmilojevicc/herdr-splits.nvim",
    cond = vim.env.HERDR_ENV == "1",
    lazy = false,
    build = ':lua require("herdr-splits").sync_herdr()',

    config = function()
        local splits = require("herdr-splits")

        splits.setup({
            neovim_amount = 3,
            at_edge = "wrap",
            nav_at_edge = "wrap",
            auto_sync_herdr = true,
        })

        local keymap_opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<C-h>", splits.move_cursor_left, keymap_opts)
        vim.keymap.set("n", "<C-j>", splits.move_cursor_down, keymap_opts)
        vim.keymap.set("n", "<C-k>", splits.move_cursor_up, keymap_opts)
        vim.keymap.set("n", "<C-l>", splits.move_cursor_right, keymap_opts)

        vim.keymap.set("n", "<A-h>", splits.resize_left, keymap_opts)
        vim.keymap.set("n", "<A-j>", splits.resize_down, keymap_opts)
        vim.keymap.set("n", "<A-k>", splits.resize_up, keymap_opts)
        vim.keymap.set("n", "<A-l>", splits.resize_right, keymap_opts)
    end,
}
