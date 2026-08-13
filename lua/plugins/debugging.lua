-- debugger
-- command please check https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
-- https://www.youtube.com/watch?v=oYzZxi3SSnM&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&index=6
return {
    -- Core DAP + UI
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup() -- must call setup() to initialize the UI

            -- VSCode-style breakpoint signs (red dot instead of the dim "B" text)
            vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })
            vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#e51400' })
            vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' })
            vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' })
            vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#888888' })

            vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
            vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '✗', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

            vim.keymap.set('n', '<F5>', function() dap.continue() end)
            vim.keymap.set('n', '<F10>', function() dap.step_over() end)
            vim.keymap.set('n', '<F11>', function() dap.step_into() end)
            vim.keymap.set('n', '<F12>', function() dap.step_out() end)
            vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
            vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
            vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
            vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },

    -- Auto-install DAP adapters via Mason (delve for Go, debugpy for Python)
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "delve", "debugpy", "codelldb" },
                automatic_installation = true,
            })
        end,
    },

    -- Go debugger (uses Delve)
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        config = function()
            require("dap-go").setup()
        end,
    },

    -- Python debugger (uses debugpy installed by Mason above)
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
            local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(mason_debugpy)
        end,
    },

    -- JavaScript / TypeScript debugger (uses vscode-js-debug under the hood)
    -- Requires: node and npm installed on your system
    {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = {
            {
                "microsoft/vscode-js-debug",
                -- --ignore-scripts 是必要的：上游 postinstall 會跑
                -- `playwright install chromium --with-deps`，那需要 sudo，
                -- 在 lazy 的無 terminal 環境下會失敗導致整個 build 中斷。
                -- 那個 chromium 只給 js-debug 自己的測試用，debug server 不需要。
                -- 最後 git checkout 還原被 npm 改掉的 package-lock.json，
                -- 否則下次 Lazy update 會因為 "local changes" 拒絕更新。
                build = "npm install --legacy-peer-deps --ignore-scripts"
                    .. " && npx gulp vsDebugServerBundle"
                    .. " && rm -rf out && mv dist out"
                    .. " && git checkout -- package-lock.json",
            },
        },
        config = function()
            require("dap-vscode-js").setup({
                debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
                adapters = { "pwa-node", "pwa-chrome" },
            })

            local dap = require("dap")

            -- nvim-dap-vscode-js calls vsDebugServer.js without a port argument,
            -- but the current vscode-js-debug requires a port. Override adapter directly.
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = {
                        vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js",
                        "${port}",
                    },
                },
            }

            for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
                dap.configurations[language] = {
                    {
                        -- Launch the current file with Node
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        -- Attach to an already-running Node process (e.g. `node --inspect`)
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach to process",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        -- Launch Chrome (useful for React / frontend dev)
                        type = "pwa-chrome",
                        request = "launch",
                        name = "Launch Chrome",
                        url = "http://localhost:3000",
                        webRoot = "${workspaceFolder}",
                    },
                }
            end
        end,
    },
}
