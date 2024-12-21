
-- telescope for fuzzy search
return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            local builtin = require('telescope.builtin')
            local actions = require("telescope.actions")
            local trouble = require("trouble.sources.telescope") -- 引入 trouble.sources.telescope
            local telescope = require('telescope')

            -- trouble nvim
            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<c-t>"] = trouble.open, -- 在插入模式中按 Ctrl-t 打開 Trouble
                        },
                        n = {
                            ["<c-t>"] = trouble.open, -- 在普通模式中按 Ctrl-t 打開 Trouble
                        },
                    },
                },
            })

            vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
            -- neet to install ripfrep in system
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end
    },
    {
        -- cool code action plugin, use <leader>ca to activate
        -- https://github.com/nvim-telescope/telescope-ui-select.nvim
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup {
              extensions = {
                ["ui-select"] = {
                  require("telescope.themes").get_dropdown {
                    -- even more opts
                  }
                }
              }
            }
            -- To get ui-select loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require("telescope").load_extension("ui-select")
        end
    }
}
