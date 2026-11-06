return {
    "sindrets/diffview.nvim",
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewFileHistory",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff" },
        { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close git diff" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git file history" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Git repository history" },
    },
}
