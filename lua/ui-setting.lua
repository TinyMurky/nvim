-- 統一設定0.11版本以後的boarder
vim.o.winborder = "rounded"

-- 補全選單（popup menu）的邊框，Neovim 0.12 新增的選項。
-- 之前這件事要靠 nvim-cmp 的 cmp.config.window.bordered() 做。
vim.o.pumborder = "rounded"
vim.o.pumheight = 12 -- 選單最多幾行，太長會蓋住畫面

-- ui2：Neovim 0.12 重新設計的訊息與 cmdline UI。
-- 最大好處是不會再被 "Press ENTER or type command to continue" 打斷，
-- 訊息改用浮動視窗顯示，cmdline 也會即時上色。
--
-- 目前還是實驗性的，所以模組路徑帶底線（vim._core），未來可能改名。
-- 用 pcall 包起來：哪天上游把它搬走或改名，也只是靜靜地退回舊 UI，
-- 不會讓整個 config 開不起來。
pcall(function()
	require("vim._core.ui2").enable()
end)
