-- use `:h vim.lsp.buf` for helper menu
return {
	-- Set up language server
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- connect between mason and lspconfig
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
	-- the lsp config that neovim actually uses
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
			-- this one broadcasts cmp-nvim-lsp capabilities to lsp servers
			-- store in ../utils/lsp_capabilities
			local capabilities = require("utils.lsp_capabilities")

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			-- ts_ls only activates for package.json projects (won't conflict with deno)
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				root_dir = function(bufnr)
					return vim.fs.root(bufnr, { "package.json" })
				end,
				single_file_support = false,
			})

			vim.lsp.config("eslint", {
				capabilities = capabilities,
			})

			vim.lsp.config("pylsp", {
				capabilities = capabilities,
			})

			-- denols only activates for deno.json / deno.jsonc projects
			vim.lsp.config("denols", {
				capabilities = capabilities,
				root_dir = function(bufnr)
					return vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
				end,
			})

			vim.lsp.config("gopls", {
				capabilities = capabilities,
			})

			vim.lsp.config("dockerls", {
				capabilities = capabilities,
			})

			vim.lsp.config("docker_compose_language_service", {
				capabilities = capabilities,
			})

			vim.lsp.enable({
				"lua_ls",
				"ts_ls",
				"eslint",
				"pylsp",
				"denols",
				"gopls",
				"dockerls",
				"docker_compose_language_service",
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
