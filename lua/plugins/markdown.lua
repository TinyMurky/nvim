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
			-- WSL：用 explorer.exe 叫起 Windows 的預設瀏覽器
			vim.cmd([[
				function! MkdpOpenInWindows(url)
					silent execute '!/mnt/c/Windows/explorer.exe ' . a:url
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
