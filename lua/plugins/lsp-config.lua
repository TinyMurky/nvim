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
					-- flutter config please check
					-- https://github.com/RobertBrunhage/nvim/blob/96b9d5709fe857d8e8b5ac0608b6c84f21f8fe39/lua/plugins/lsp.lua
					"astro", -- dart sdk ships with LSP
                    "eslint", -- eslint-lsp
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
		config = function()
			-- need to manually setup all lsp
			-- https://github.com/neovim/nvim-lspconfig
			local lsp_config = require("lspconfig")

            -- this one brot cast cmp-nvim-lsp to lsp server
            -- ever setup need to use this
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lsp_config.lua_ls.setup({
                capabilities = capabilities
            })
			lsp_config.ts_ls.setup({
                capabilities = capabilities
            })
            lsp_config.eslint.setup({
                capabilities = capabilities
            })

			-- setup lsp hover key bind to K (shift + k)
			-- can open doc from server
			-- Check youtube for more command
			-- https://www.youtube.com/watch?v=S-xzYgTLVJE&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=3
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

			-- dart related setup

			local dartExcludedFolders = {
				-- vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
				vim.fn.expand("$HOME/.pub-cache"),
				-- vim.fn.expand("/opt/homebrew/"),
				-- vim.fn.expand("$HOME/tools/flutter/"),
				vim.fn.expand("$HOME/flutter/"), -- where my flutter installed
			}

			-- dcm dart code matric please watch: https://dcm.dev/docs/getting-started/installation/linux/?utm_source=chatgpt.com
			-- download deb https://github.com/CQLabs/homebrew-dcm/releases
			lsp_config["dcmls"].setup({
				capabilities = capabilities,
				cmd = {
					"dcm",
					"start-server",
				},
				filetypes = { "dart", "yaml" },
				settings = {
					dart = {
						analysisExcludedFolders = dartExcludedFolders,
					},
				},
			})

			lsp_config["dartls"].setup({
				capabilities = capabilities,
				cmd = {
					"dart",
					"language-server",
					"--protocol=lsp",
					-- "--port=8123",
					-- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
				},
				filetypes = { "dart" },
				init_options = {
					onlyAnalyzeProjectsWithOpenFiles = false,
					suggestFromUnimportedLibraries = true,
					closingLabels = true,
					outline = false,
					flutterOutline = false,
				},
				settings = {
					dart = {
						analysisExcludedFolders = dartExcludedFolders,
						updateImportsOnRename = true,
						completeFunctionCalls = true,
						showTodos = true,
					},
				},
			})

			lsp_config.astro.setup({
				capabilities = capabilities,
			})
			-- Hot reload :)
			require("dart-tools")
		end,
	},
}
