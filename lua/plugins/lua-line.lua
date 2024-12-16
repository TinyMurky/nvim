return {
    'nvim-lualine/lualine.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' }
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',
            },
            sections = {
                lualine_c = {
                    {
                      'filename',
                      path = 1 -- 設置為 1 顯示相對路徑，設置為 3 顯示完整路徑
                    }
                  }
            }
        })
    end
}
