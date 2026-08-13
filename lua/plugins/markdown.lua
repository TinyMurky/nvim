-- Markdown 相關：buffer 內即時渲染 + 瀏覽器預覽
return {
	-- 在 buffer 裡直接渲染 markdown（heading、code block、表格、checkbox…）
	-- 進入 insert mode 時會自動變回原始文字，方便編輯
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown" },
		opts = {
			-- normal/command 模式渲染，insert/visual 顯示原始文字
			render_modes = { "n", "c", "t" },
			heading = {
				sign = false, -- 不在 sign column 放 #，避免跟 git sign 打架
			},
			code = {
				sign = false,
				width = "block",
				right_pad = 2,
			},
			checkbox = {
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
		},
		keys = {
			{
				"<leader>mr",
				"<cmd>RenderMarkdown toggle<cr>",
				desc = "Toggle markdown render",
				ft = "markdown",
			},
		},
	},

	-- 開 Windows 瀏覽器做完整預覽（圖片、mermaid、同步捲動）
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		init = function()
			-- WSL：用 explorer.exe 叫起 Windows 的預設瀏覽器。
			-- 用 jobstart 而不是 `!`：`!` 會卡住 nvim 畫面，而且 explorer.exe
			-- 不管成功與否都回傳 exit code 1，用 `!` 會被 nvim 誤報成錯誤。
			_G.MkdpOpenInWindows = function(url)
				vim.fn.jobstart({ "/mnt/c/Windows/explorer.exe", url }, { detach = true })
			end
			vim.cmd([[
				function! MkdpOpenInWindows(url)
					call v:lua.MkdpOpenInWindows(a:url)
				endfunction
			]])
			vim.g.mkdp_browserfunc = "MkdpOpenInWindows"
			vim.g.mkdp_auto_close = 1 -- 切離 markdown buffer 時關掉預覽分頁
			vim.g.mkdp_theme = "dark"
		end,
		keys = {
			{
				"<leader>mp",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Toggle markdown preview in browser",
				ft = "markdown",
			},
		},
	},
}
