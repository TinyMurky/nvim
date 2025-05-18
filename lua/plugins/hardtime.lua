-- https://github.com/m4xshen/hardtime.nvim
return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify"
    },
  opts = {
    -- disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
    -- 其他預設選項可以留空或自訂
    notification = true,
    disable_mouse = false,
  },
  config = function(_, opts)
    require("hardtime").setup(opts)

    -- 建議設定：避免 hint 被 mode 蓋掉
    vim.opt.showmode = false

    -- 建議：可選 nvim-notify 顯示提示訊息（需安裝 notify）
    -- vim.notify = require("notify")
  end,
}
