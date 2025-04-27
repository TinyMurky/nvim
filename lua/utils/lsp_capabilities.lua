-- go nvim 和 lsp.config 需要共用一個 capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

return capabilities
