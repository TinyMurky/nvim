-- Rust support via rustaceanvim
-- Install rust-analyzer: rustup component add rust-analyzer
-- Install codelldb (debugger): :MasonInstall codelldb
-- https://github.com/mrcjkb/rustaceanvim
return {
    "mrcjkb/rustaceanvim",
    version = "^9",
    ft = "rust",
    init = function()
        vim.g.rustaceanvim = function()
            local capabilities = require("utils.lsp_capabilities")
            local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

            return {
                dap = {
                    adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path),
                },
                server = {
                    capabilities = capabilities,
                    default_settings = {
                        ["rust-analyzer"] = {
                            -- Keep project loading focused on the default feature set.
                            -- Use `cargo.features = "all"` only when all features are
                            -- required for the crate currently being edited.
                            cargo = {
                                features = {},
                                -- Load tests, examples and benches so they receive full
                                -- completion, navigation and semantic analysis.
                                allTargets = true,
                            },
                            -- Analyze code guarded by `#[cfg(test)]`.
                            cfg = {
                                setTest = true,
                            },
                            check = {
                                command = "check",
                                -- Check every target in the current package, including tests.
                                allTargets = true,
                                -- Check the package containing the current file instead of
                                -- re-checking the entire workspace.
                                workspace = false,
                            },
                            -- Let rust-analyzer choose based on the available CPU.
                            -- A fixed value can underuse large machines.
                        },
                    },
                },
            }
        end

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function(args)
                local opts = { buffer = args.buf }
                vim.keymap.set("n", "<leader>rt", "<cmd>RustLsp testables<cr>",
                    vim.tbl_extend("force", opts, { desc = "Rust: run testables" }))
                vim.keymap.set("n", "<leader>rd", "<cmd>RustLsp debuggables<cr>",
                    vim.tbl_extend("force", opts, { desc = "Rust: debug testables" }))
            end,
        })
    end,
}
