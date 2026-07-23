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
    vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", { desc = "Open Neotree left" })
    require("neo-tree").setup({
      default_component_configs = {
        icon = {
          -- folder_open = "", -- 展開圖示
        },
      },
      window = {
        position = "left",
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,     -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
      commands = {
        copy_filename_to_clipboard = function(state)
          local node = state.tree:get_node()
          local filename = vim.fn.fnamemodify(node.path, ":t")
          vim.fn.setreg("+", filename)
          vim.notify("Copied filename: " .. filename)
        end,
        copy_path_to_clipboard = function(state)
          local node = state.tree:get_node()
          vim.fn.setreg("+", node.path)
          vim.notify("Copied path: " .. node.path)
        end,
      },
      window = {
        mappings = {
          ["Y"] = "copy_filename_to_clipboard",
          ["gy"] = "copy_path_to_clipboard",
        },
      },
    })
  end,
}
