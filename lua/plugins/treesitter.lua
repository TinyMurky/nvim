-- nvim-treesitter `main` 分支（Neovim 0.12 以上專用）
--
-- 為什麼不是 master：
--   master 上游已明確宣告不支援 0.12，最後一個 commit 就是把 README 改成
--   "Neovim 0.10 or 0.11 (Neovim 0.12 is not supported)"。
--   0.12 移除了 Query:iter_matches() 的 `all` 選項，match[capture_id] 現在
--   一律是 TSNode[] 陣列而不是單一 node，master 的 query_predicates.lua
--   還當成單一 node 用，於是開 markdown 就噴
--   "attempt to call method 'range' (a nil value)"。
--
-- main 分支沒有 require('nvim-treesitter.configs').setup()，
-- highlight 與 indent 都要自己掛 FileType autocmd。
-- parser 安裝目錄改成 stdpath('data')/site，不再放在外掛資料夾裡。
--
-- 用 :TSInstall <lang> 加新語言，:TSUpdate 更新 parser。

local ensure_installed = {
	"lua",
	"javascript",
	"yaml",
	"typescript",
	"tsx",
	"python",
	"dart",
	"go",
	"rust",
	-- render-markdown.nvim 需要這兩個
	"markdown",
	"markdown_inline",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main 分支建議不要 lazy load
	build = ":TSUpdate",
	config = function()
		-- install() 是非同步的，而且對已安裝的語言會直接跳過
		-- （install.lua: `if not force and vim.list_contains(config.get_installed(), lang)`），
		-- 所以每次啟動都呼叫幾乎沒有成本。
		require("nvim-treesitter").install(ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft)
				if not lang then
					return
				end

				-- parser 還沒裝好（或裝壞了）就安靜跳過，
				-- 不要每次開檔都噴一次錯誤
				if not pcall(vim.treesitter.start, args.buf, lang) then
					return
				end

				-- indent：Neovim core 沒有 vim.treesitter.indentexpr，
				-- 這個只有 nvim-treesitter 提供
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
