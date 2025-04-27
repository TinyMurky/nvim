-- Tudorial:
-- https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn

-- package manager has two kind
-- package.nvim
-- lazy.nvim (lazy.folke.io/installation)
-- below install lazy.nvim if not yet installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- check if lazy installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- setup how error show on screen
-- 這個要在最後reload確保其他檔案不要蓋過這個設定
vim.diagnostic.config({
  virtual_text = false,  -- ✅ 不在行內（inline）顯示錯誤
  signs = true,          -- ✅ 左邊 signcolumn 還是有小圖示（警告/錯誤）
  update_in_insert = false, -- ✅ insert 模式時不會即時顯示，等到 normal 模式再出現
  underline = true,      -- ✅ 出錯的地方會有底線（很細的 underline，不會擾人）
  severity_sort = true,  -- ✅ 錯誤嚴重度排序（錯誤比警告高）
  float = {
    border = "rounded",  -- ✅ 漂亮圓角邊框的浮動小視窗
    source = "always",   -- ✅ 浮窗裡會寫是哪個 LSP 報錯
    header = "",         -- ✅ 浮窗不要標題，簡潔
    prefix = "",         -- ✅ 浮窗不要前綴符號
  },
})



-- vim tweak, vim key bind
require("vim-options")
-- Load Lazy
-- package in plugins will be download, but neet to use require mannually
require("lazy").setup("plugins") -- plugins.lua
