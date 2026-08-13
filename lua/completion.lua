-- 原生補全（Neovim 0.12），取代 nvim-cmp
--
-- 舊的 nvim-cmp 設定還留在 lua/plugins/completions.lua，只是被 enabled = false
-- 關掉了。要退回去的話把那個 flag 改回 true，再把這個檔從 init.lua 拿掉即可。
--
-- 對照表：
--   cmp.config.window.bordered()   -> 'pumborder'（在 ui-setting.lua）
--   sources = { nvim_lsp }          -> 'complete' 的 o 旗標（omnifunc = LSP）
--   sources = { buffer }            -> 'complete' 的 . w b 旗標
--   自動跳出選單                     -> 'autocomplete'
--   cmp.setup.cmdline({'/', '?'})   -> 下面的 cmdline autocompletion

-- ── 插入模式補全 ────────────────────────────────────────────────

vim.o.autocomplete = true -- 打字時自動跳出補全選單
vim.o.autocompletedelay = 50 -- 延遲 50ms 再跳，避免打字被選單追著跑

-- 補全來源，依序（前面的來源會分到比較多時間）：
--   .  目前 buffer
--   w  其他視窗的 buffer
--   b  其他已載入的 buffer
--   o  omnifunc — LSP attach 時 Neovim 會把 omnifunc 設成 vim.lsp.omnifunc，
--      所以這個旗標就等於「LSP 補全」
vim.o.complete = ".,w,b,o"

-- menuone  只有一個候選也要顯示選單
-- noselect 不預選第一項，要自己按 <C-n>/<C-p> 或 <Tab> 選
-- popup    選中項目時用浮動視窗顯示文件（等同 cmp 的 documentation 視窗）
-- fuzzy    模糊比對
vim.o.completeopt = "menuone,noselect,popup,fuzzy"

-- LSP 補全要明確開啟，而且 autotrigger 才會在打到 server 定義的
-- triggerCharacters（例如 `.`）時自動跳出來
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("NativeLspCompletion", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

-- 'completeopt' 的 popup 說明浮窗，其 border 在 Neovim 內部被寫死成 "none"，
-- 'pumborder' 和 'winborder' 都管不到它（'pumborder' 只作用在選單本身）。
-- 這裡在每次選取變更後把邊框補上。
--
-- 判斷條件挑得比較嚴，避免誤改到其他外掛的浮窗：
-- 不是目前視窗、浮動、不可聚焦、border 是 none、buffer 是無名的 nofile。
vim.api.nvim_create_autocmd("CompleteChanged", {
	group = vim.api.nvim_create_augroup("CompletionInfoBorder", { clear = true }),
	callback = function()
		vim.schedule(function()
			local cur = vim.api.nvim_get_current_win()
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if win ~= cur then
					local cfg = vim.api.nvim_win_get_config(win)
					if cfg.relative ~= "" and cfg.focusable == false and cfg.border == "none" then
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].buftype == "nofile" and vim.api.nvim_buf_get_name(buf) == "" then
							pcall(vim.api.nvim_win_set_config, win, { border = "rounded" })
						end
					end
				end
			end
		end)
	end,
})

-- ── 按鍵：盡量貼近原本 nvim-cmp 的手感 ──────────────────────────
--
-- 上下箭頭原生就能在選單裡移動，不用設定。
-- 跟 <C-n>/<C-p> 的差別是：箭頭只移動選取、不會邊移邊把文字塞進 buffer。
--
-- 原生預設：<C-n>/<C-p> 上下選，<C-y> 確認，<C-e> 取消。
-- <C-e> 跟原本 cmp 一樣，不用改。

-- <C-j> / <C-k> 在選單裡上下移動，跟 smart-splits 的視窗跳躍同一組手指。
-- 只在選單開著時攔截；沒開選單時原樣送出去，維持 i_CTRL-J（換行）
-- 和 i_CTRL-K（輸入 digraph）的預設行為。
vim.keymap.set("i", "<C-j>", function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
end, { expr = true, desc = "Next completion item" })

vim.keymap.set("i", "<C-k>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
end, { expr = true, desc = "Prev completion item" })

-- <C-Space> 手動觸發 LSP 補全（原本 cmp 的 <C-Space>）
vim.keymap.set("i", "<C-Space>", function()
	vim.lsp.completion.get()
end, { desc = "Trigger LSP completion" })

-- <Tab> 一鍵三用：
--   1. 選單開著     -> 確認選取（原本 cmp 綁的是 <tab> confirm）
--   2. snippet 展開中 -> 跳到下一個欄位
--   3. 其他         -> 就是一個普通的 Tab
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	end
	if vim.snippet.active({ direction = 1 }) then
		return "<Cmd>lua vim.snippet.jump(1)<CR>"
	end
	return "<Tab>"
end, { expr = true, desc = "Confirm completion / jump snippet / tab" })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>"
	end
	if vim.snippet.active({ direction = -1 }) then
		return "<Cmd>lua vim.snippet.jump(-1)<CR>"
	end
	return "<S-Tab>"
end, { expr = true, desc = "Prev completion item / jump snippet back" })

-- ── Cmdline 補全（取代 cmp.setup.cmdline）───────────────────────

vim.o.wildmode = "noselect:lastused,full"
vim.o.wildoptions = "pum"

vim.api.nvim_create_autocmd("CmdlineChanged", {
	group = vim.api.nvim_create_augroup("CmdlineAutocomplete", { clear = true }),
	pattern = { ":", "/", "?" },
	callback = function()
		vim.fn.wildtrigger()
	end,
})

-- 保留 <Up>/<Down> 翻歷史紀錄的行為（選單開著時預設會被吃掉）
vim.keymap.set("c", "<Up>", function()
	return vim.fn.wildmenumode() == 1 and "<C-e><Up>" or "<Up>"
end, { expr = true })
vim.keymap.set("c", "<Down>", function()
	return vim.fn.wildmenumode() == 1 and "<C-e><Down>" or "<Down>"
end, { expr = true })
