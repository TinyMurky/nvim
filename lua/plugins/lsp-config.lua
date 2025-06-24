-- use `:h vim.lsp.buf` for helper menu
return {
	-- Set up language server
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- connect between  mason and
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				-- Put language server in here
				-- All lsp:
				-- https://github.com/williamboman/mason-lspconfig.nvim
				ensure_installed = {
					"lua_ls",
					"ts_ls", -- typescript
					"eslint", -- eslint-lsp
					"pylsp",
					"denols", -- deno
					"gopls", -- go
					"dockerls", -- dockerfile-language-server
					"docker_compose_language_service", --  docker-compose-language-service
				},
			})
		end,
	},
	-- the lsp config that neo vim actually use
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",

			-- support for dart hot reload on save
			"RobertBrunhage/dart-tools.nvim",
		},
		opts = { -- add hint
			inlay_hints = { enabled = true },
		},
		config = function()
			-- need to manually setup all lsp
			-- https://github.com/neovim/nvim-lspconfig
			local lsp_config = require("lspconfig")

			-- this one brot cast cmp-nvim-lsp to lsp server
			-- ever setup need to use this
			-- store in ../utils/lsp_capabilities
			local capabilities = require("utils.lsp_capabilities")

			lsp_config.lua_ls.setup({
				capabilities = capabilities,
			})

			lsp_config.ts_ls.setup({
				capabilities = capabilities,
				root_dir = lsp_config.util.root_pattern("package.json"),
				single_file_support = false -- won't confict with deno
			})

			lsp_config.eslint.setup({
				capabilities = capabilities,
			})

			lsp_config.pylsp.setup({
				capabilities = capabilities,
			})

			lsp_config.denols.setup({
				capabilities = capabilities,
				root_dir = lsp_config.util.root_pattern("deno.json", "deno.jsonc"),
			})

			-- For go
			lsp_config.gopls.setup({
				capabilities = capabilities,
			})

			-- For docker
			lsp_config.dockerls.setup({
				capabilities = capabilities,
			})

			lsp_config.docker_compose_language_service.setup({
				capabilities = capabilities,
			})

			-- setup lsp hover key bind to K (shift + k)
			-- can open doc from server
			-- Check youtube for more command
			-- https://www.youtube.com/watch?v=S-xzYgTLVJE&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=3
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})


		end,
	},
}
