-- go nvim 和 lsp.config 需要共用一個 capabilities
--
-- 原本是 require('cmp_nvim_lsp').default_capabilities(...)，
-- 換成原生補全之後 cmp-nvim-lsp 已停用，改用 Neovim 內建的。
--
-- Neovim 0.12 的預設 capabilities 已經包含 cmp-nvim-lsp 以前補的東西：
--   textDocument.completion.completionItem.snippetSupport = true
--   resolveSupport.properties = { additionalTextEdits, command, documentation }
-- 所以直接用原生的就夠了。
local capabilities = vim.lsp.protocol.make_client_capabilities()

return capabilities
