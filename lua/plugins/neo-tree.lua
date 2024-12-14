
-- file system
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        -- Neo tree keybind
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', { desc = 'Open Neotree left'})
        require("neo-tree").setup({
            default_component_configs = {
                icon = {
                    -- folder_open = "", -- 展開圖示
                },
            },
        })
    end
}
