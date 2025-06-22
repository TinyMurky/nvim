-- 這個檔案放置跟畫面分割與畫面跳躍有關的按鈕

-- 以下是分割畫面
vim.keymap.set("n", "<leader>sl", ":set splitright<CR>:vsplit<CR>", { noremap = true, silent = true }) -- 開右
vim.keymap.set("n", "<leader>sh", ":set nosplitright<CR>:vsplit<CR>", { noremap = true, silent = true }) -- 開上
vim.keymap.set("n", "<leader>sj", ":set splitbelow<CR>:split<CR>", { noremap = true, silent = true }) -- 開下
vim.keymap.set("n", "<leader>sk", ":set nosplitbelow<CR>:split<CR>", { noremap = true, silent = true }) -- 開左

-- 以下是smart split的設定
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)