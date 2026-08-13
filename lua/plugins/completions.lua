-- https://github.com/hrsh7th/nvim-cmp
--
-- ⚠️ 這整組已經停用，改用 Neovim 0.12 的原生補全（見 lua/completion.lua）。
--
-- 設定沒有刪掉，只是把 enabled 關成 false，方便隨時退回：
--   1. 把下面的 ENABLED 改成 true
--   2. 把 init.lua 裡的 require("completion") 註解掉
--   3. 把 lua/utils/lsp_capabilities.lua 改回用 cmp_nvim_lsp
--   4. 把 cmp-nvim-lsp 加回 lua/plugins/lsp-config.lua 的 dependencies
--   5. :Lazy sync
--
-- 換過去之後少了什麼（原生補全沒有的）：
--   - friendly-snippets：那是 vscode 格式的獨立 snippet 集，原生沒有對應來源。
--     LSP server 自己提供的 snippet 仍然正常展開（vim.snippet）。
--   - <C-b>/<C-f> 捲動文件浮窗。
local ENABLED = false

return {
    {
        -- https://github.com/hrsh7th/cmp-nvim-lsp
        -- get snippet from lsp server
        "https://github.com/hrsh7th/cmp-nvim-lsp",
        enabled = ENABLED,
    },
	{
		"L3MON4D3/LuaSnip",
		enabled = ENABLED,
		dependencies = {
			"saadparwaiz1/cmp_luasnip", -- put snippit into code
            "rafamadriz/friendly-snippets" -- This is the true snippet that actually used, like vs code
		},
	},
	{
		"hrsh7th/nvim-cmp",
		enabled = ENABLED,
		config = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			})

			-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
			-- Set configuration for specific filetype.
			--[[ cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                  { name = 'git' },
                }, {
                  { name = 'buffer' },
                })
             })
             require("cmp_git").setup() ]]
			--

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
		end,
	},
}
