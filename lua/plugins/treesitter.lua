-- Use ":TSUpdate" for treesitter higlight
-- -- this will transform braces in code into tree, for better highlight
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter_config = require("nvim-treesitter.configs")
		treesitter_config.setup({
			-- auto_install = true, -- install when meet new language
			ensure_installed = {"lua", "javascript", "yaml", "typescript", "tsx", "python", "dart"},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
