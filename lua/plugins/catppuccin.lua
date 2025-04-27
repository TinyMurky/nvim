-- Ref: https://github.com/catppuccin/nvim
-- set up catppuchin color scheme
return {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    -- If config is set, it will automatic use require("xxxPackage").setup()
    config = function()
        require("catppuccin").setup({
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            }
        }) -- load colorscheme into setup
        -- use colorscheme
        vim.cmd.colorscheme "catppuccin"
    end
}
