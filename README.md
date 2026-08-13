# Set Up

Please place this `nvim` folder inside

```
/home/tinymurky/.config
```

neovim will read it automatically

## Pre-install

Need to install `dcm` and `dart`

- ripgrep for tree
- dcm server please check [deb download linl](https://github.com/CQLabs/homebrew-dcm/releases) or check [dcm website](https://dcm.dev/docs/getting-started/installation/linux/?utm_source=chatgpt.com)
- dart can be install by flutter
- `wl-copy` in system for copy paste to clip board
- Use `:Mason` to insatll formatter (press `i`) and lint that been used in `none-ls`
- lazy git: https://github.com/jesseduffield/lazygit,
- https://www.youtube.com/watch?v=CPLdltN7wgE

## Install lint

lint will not auto install

Please use `:Mason` and visit lint to install linter like `revive`

## Tmux Integration

This project includes a pre-configured `tmux.conf` in `./tmux/tmux.conf` that seamlessly integrates with Neovim using `smart-splits.nvim`.

### How to use it?

1.  Symlink the `tmux.conf` to your home directory:
    ```bash
    ln -s ~/.config/nvim/tmux/tmux.conf ~/.tmux.conf
    ```
2.  Reload tmux configuration:
    ```bash
    tmux source ~/.tmux.conf
    ```

### Key Features (Seamless between Tmux & Neovim)

🧭 **Move between splits (Tmux Panes & Neovim Splits)**

- `<C-h>` : Move to the left split/pane
- `<C-j>` : Move to the split/pane below
- `<C-k>` : Move to the split/pane above
- `<C-l>` : Move to the right split/pane
- `<C-\>` : Move to the last active split/pane

🚀 **Resize split (Tmux Panes & Neovim Splits)**

- `<A-h>` (Alt+h) : Shrink/Resize to the left
- `<A-j>` (Alt+j) : Shrink/Resize downward
- `<A-k>` (Alt+k) : Shrink/Resize upward
- `<A-l>` (Alt+l) : Shrink/Resize to the right

✂️ **Split Panes (Tmux logic aligned with Neovim)** 

(Prefix is Ctrl-a)
it need to press Ctrl-a => release => next buttom

- `Prefix + h` : Split pane to the left (hb)
- `Prefix + j` : Split pane downward (v)
- `Prefix + k` : Split pane upward (vb)
- `Prefix + l` : Split pane to the right (h)
- `Prefix + x` : kill

### Install TPM

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

put this line at the bottom of `./tmux/tmux.conf`
```
# 這裡列出你想要安裝的外掛
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# 加入你剛才想要的 Nord 主題
set -g @plugin 'nordtheme/tmux'

# 初始化 TMUX 外掛管理員 (這行必須保持在檔案最底部)
run '~/.tmux/plugins/tpm/tpm'
```

use `tmux source ~/.tmux.conf` to refresh settings
use `prefix + I` to install plugin

### Session Persistence (tmux-resurrect + tmux-continuum)

Tmux sessions are lost on reboot by default. These plugins save and restore them.

- `tmux-resurrect`: manual save/restore
- `tmux-continuum`: auto-saves every 15 minutes and restores on boot

| Key | Action |
| --- | --- |
| `Prefix + Ctrl-s` | Save session |
| `Prefix + Ctrl-r` | Restore session |

Auto-restore on boot is enabled via `@continuum-restore 'on'` in `tmux.conf`.

---

## Cool command

### Code Related

- `:Lazy`: open lazy GUI
- `K`: hover code effect
- `gd`: go to definition
- `<leader>ca`: do some stuff like vs code
- `<space>f`: format
- `<ctrl> + c` in normal: copy to clipboard
- `<ctrl> + p` in normal: paste to clipboard
- `<leader>lg`: lazy git
- `<leader> + i`: to see error message
- `]e`: jump to next error
- `]w`: jump to next warning
- `[e`: jump to previous error
- `[w`: jump to previous error
- `<leader> + H (capital)`: open inlay hint
- `gc`: change line to command

> Telescope

- `<ctrl> + p`: 'Telescope find files'
- `<leader> + fg`: 'Telescope live grep'
- `<leader> + fg`: Telescope buffers'
- `<leader> + fg`: 'Telescope help tags'

> Split scream

- `<leader> + sl` : Open right
- `<leader> + sk` : Open up
- `<leader> + sj` : Open down
- `<leader> + sh` : Open left

> Smart Splits

🚀 Resize split

- `<A-h>` : Shrink window to the left
- `<A-j>` : Shrink window downward
- `<A-k>` : Shrink window upward
- `<A-l>` : Shrink window to the right

🧭 Move between splits

- `<C-h>` : Move to the left split
- `<C-j>` : Move to the split below
- `<C-k>` : Move to the split above
- `<C-l>` : Move to the right split
- `<C-\>` : Move to the last active split

🔄 Swap buffers between splits

- `<leader><leader>h` : Swap buffer to the left split
- `<leader><leader>j` : Swap buffer to the bottom split
- `<leader><leader>k` : Swap buffer to the top split
- `<leader><leader>l` : Swap buffer to the right split

## Debugger (nvim-dap)

Supports Go, Python, JavaScript, and TypeScript. The UI opens automatically when a debug session starts.

### First-time setup

After opening Neovim, run:

```
:Lazy sync
```

This installs all plugins. Mason will also auto-install `delve` (Go) and `debugpy` (Python).

**JavaScript / TypeScript** requires `node` and `npm` on your system. The `vscode-js-debug` adapter is compiled automatically during plugin install.

### Keymaps

| Key | Action |
| --- | --- |
| `<F5>` | Continue / Start |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<Leader>b` | Toggle breakpoint |
| `<Leader>B` | Set conditional breakpoint |
| `<Leader>lp` | Set log point |
| `<Leader>dr` | Open REPL |
| `<Leader>dl` | Re-run last session |

### Language adapters

| Language | Adapter | Installed by |
| --- | --- | --- |
| Go | `nvim-dap-go` (Delve) | Mason (`delve`) |
| Python | `nvim-dap-python` (debugpy) | Mason (`debugpy`) |
| JavaScript / TypeScript | `nvim-dap-vscode-js` (vscode-js-debug) | npm build step |

### JS/TS debug configurations

Three configs are available per language (select when you press `<F5>`):

- **Launch file** — runs the current file with Node
- **Attach to process** — attaches to a running `node --inspect` process
- **Launch Chrome** — opens Chrome pointed at `http://localhost:3000` (for frontend/React)

---

## Rust (rustaceanvim)

> Powered by [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) + `rust-analyzer` + `codelldb`

### First-time setup

**1. Install Rust toolchain components**

```bash
rustup component add rust-analyzer
rustup component add clippy
```

**2. Install plugins and debugger**

Open Neovim and run:

```
:Lazy sync
```

This installs `rustaceanvim`. Mason will also auto-install `codelldb` (the Rust debugger).

### Features

| Feature | Detail |
| --- | --- |
| LSP | `rust-analyzer` managed by rustaceanvim |
| Linter | `clippy` runs on every save (via `check.command`) |
| Formatter | `rustfmt` via rust-analyzer, auto-runs on save |
| Debugger | `codelldb` via Mason + nvim-dap |
| Cargo features | All features enabled by default (`allFeatures = true`) |

### Keymaps

**Standard LSP (inherited)**

| Key | Action |
| --- | --- |
| `K` | Hover documentation |
| `gd` | Go to definition |
| `<leader>ca` | Code action |
| `<space>f` | Format |

**Rust-specific (rustaceanvim)**

| Key / Command | Action |
| --- | --- |
| `<leader>rt` | List and run testables (`:RustLsp testables`) — put cursor in/near a `#[test]` fn |
| `<leader>rd` | List and debug testables via codelldb (`:RustLsp debuggables`) |
| `:RustLsp runnables` | List and run all `cargo run` / `cargo test` targets |
| `:RustLsp debuggables` | List and debug targets with codelldb |
| `:RustLsp expandMacro` | Expand macro under cursor (recursive) |
| `:RustLsp codeAction` | Richer code actions than standard `<leader>ca` |
| `:RustLsp hover actions` | Hover with extra Rust-specific actions |
| `:RustLsp explainError` | Explain the diagnostic error under cursor |
| `:RustLsp renderDiagnostic` | Render diagnostic as rendered rustc output |
| `:RustLsp flyCheck` | Manually trigger `cargo check` / `clippy` |
| `:RustLsp openDocs` | Open docs.rs for the symbol under cursor |

> `<leader>rt` / `<leader>rd` are buffer-local, only mapped in `.rs` files.

**Debugger** (same nvim-dap keymaps, uses codelldb)

| Key | Action |
| --- | --- |
| `<F5>` | Continue / Start |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<Leader>b` | Toggle breakpoint |
| `<Leader>B` | Set conditional breakpoint |
| `<Leader>dr` | Open REPL |

---

## Unit test with [gotests](https://github.com/cweill/gotests) and testify

> Ref [go.nvim](https://github.com/ray-x/go.nvim)

### Keymaps

| Key | Action |
| --- | --- |
| `<leader>tf` | Run test for current function (`GoTestFunc`) |
| `<leader>tF` | Run test for current file (`GoTestFile`) |


Support table based unit test auto generate, parse current function/method name using treesitter

| command                  | Description                                             |
| ------------------------ | ------------------------------------------------------- |
| GoTestFunc               | run test for current func                               |
| GoTestFunc -s            | select the test function you want to run                |
| GoTestFunc -tags=yourtag | run test for current func with `-tags yourtag` option   |
| GoTestFile               | run test for current file                               |
| GoTestFile -tags=yourtag | run test for current folder with `-tags yourtag` option |
| GoTestPkg                | run test for current package/folder                     |
| GoTestPkg -tags=yourtag  | run test for current folder with `-tags yourtag` option |
| GoAddTest [-parallel]    | Add test for current func                               |
| GoAddExpTest [-parallel] | Add tests for exported funcs                            |
| GoAddAllTest [-parallel] | Add tests for all funcs                                 |

GoTestXXX Arguments

| arguments | Description   |
| --------- | ------------- |
| -v        | verbose mode  |
| -c        | compile       |
| -C        | coverprofile  |
| -n        | count         |
| -t        | tags          |
| -f        | fuzz          |
| -bench    | bench test    |
| -m        | metric        |
| -s        | select        |
| -p        | package       |
| -F        | floaterm mode |
| -a        | args          |

Note: For GoTestXXX

You can add available arguments with long name or character flag e.g.
`GoTest -tags=integration ./internal/web -b=. -count=1 -`

You can also add other unmapped arguments after the `-a` or `-args` flag `GoTest -a mock=true`

---

## Markdown (render-markdown.nvim + markdown-preview.nvim)

設定檔在 `lua/plugins/markdown.lua`。兩個外掛互補：

- **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)** — 直接在 buffer 裡渲染（heading 上色、code block 背景、表格對齊、checkbox icon）。進入 insert / visual 模式會自動變回原始文字，方便編輯。
- **[markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)** — 開瀏覽器看完整 render（圖片、mermaid、同步捲動）。

### Pre-install

- 需要 `node` / `npm`（markdown-preview 第一次載入時會用 `mkdp#util#install()` 自動裝前端）
- treesitter 的 `markdown` 與 `markdown_inline` parser（已加進 `treesitter.lua` 的 `ensure_installed`，必要時手動跑 `:TSUpdate`）

### Keymaps

只在 markdown 檔案生效：

| Key | Action |
| --- | --- |
| `<leader>mr` | 切換 buffer 內渲染 (`:RenderMarkdown toggle`) |
| `<leader>mp` | 切換瀏覽器預覽 (`:MarkdownPreviewToggle`) |

### Commands

| Command | Description |
| ------- | ----------- |
| `:RenderMarkdown` | 開啟 buffer 內渲染 |
| `:RenderMarkdown disable` | 關閉渲染，顯示原始文字 |
| `:RenderMarkdown toggle` | 切換 |
| `:RenderMarkdown expand` / `contract` | 增減渲染的視窗寬度 |
| `:MarkdownPreview` | 開瀏覽器預覽 |
| `:MarkdownPreviewStop` | 關閉預覽 |
| `:MarkdownPreviewToggle` | 切換 |
| `:call mkdp#util#install()` | 手動重裝預覽的前端依賴（預覽開不起來時用） |

### WSL 注意事項

`markdown-preview` 預設會在 WSL 裡找不到瀏覽器。`markdown.lua` 內已設定 `g:mkdp_browserfunc`，
改用 `/mnt/c/Windows/explorer.exe` 叫起 **Windows 的預設瀏覽器**：

```lua
function! MkdpOpenInWindows(url)
	silent execute '!/mnt/c/Windows/explorer.exe ' . a:url
endfunction
```

如果瀏覽器有開但頁面空白，通常是 WSL2 的 localhost forwarding 沒生效，
可以改用 WSL 的 IP：在 `init` 裡加 `vim.g.mkdp_open_to_the_world = 1` 與 `vim.g.mkdp_ip = "0.0.0.0"`，
然後在 Windows 用 `hostname -I` 拿到的 IP 連。

---

## Lazy 疑難排解

> `:Lazy sync` 會**更新所有外掛**。只想裝新加的外掛時用 `:Lazy install`，比較不會翻出既有外掛的更新問題。

### `vscode-js-debug`：build 失敗、JS debugger 起不來

症狀（`:Lazy` 裡看到）：

```
sudo: a terminal is required to read the password
Failed to install browsers
npm error command sh -c playwright install chromium --with-deps --only-shell
```

原因：上游的 `postinstall` 會跑 `playwright install chromium --with-deps`，`--with-deps` 需要 sudo，
lazy 沒有 terminal 可以輸密碼 → build 中斷 → `out/` 沒產生 → `pwa-node` adapter 找不到
`out/src/vsDebugServer.js`。那個 chromium 只給 js-debug 自己的測試用，debug server 不需要。

`lua/plugins/debugging.lua` 的 build 已加上 `--ignore-scripts` 避開。若還是壞掉，手動重建：

```bash
cd ~/.local/share/nvim/lazy/vscode-js-debug
git checkout -- package-lock.json
npm install --legacy-peer-deps --ignore-scripts
npx gulp vsDebugServerBundle
rm -rf out && mv dist out
git checkout -- package-lock.json   # npm 又會改掉它
```

驗證：

```bash
ls ~/.local/share/nvim/lazy/vscode-js-debug/out/src/vsDebugServer.js
```

### `vscode-js-debug`：`You have local changes in ... package-lock.json`

`npm install` 會改動 `package-lock.json`，lazy 就拒絕更新。還原即可：

```bash
git -C ~/.local/share/nvim/lazy/vscode-js-debug checkout -- package-lock.json
```

### `LuaSnip`：`Submodule 'deps/jsregexp' could not be updated`

```
error: Entry 'deps/jsregexp/.github/workflows/test.yml' not uptodate. Cannot merge.
```

submodule 裡有髒檔案（通常是 build 產物）。清乾淨再同步：

```bash
cd ~/.local/share/nvim/lazy/LuaSnip
git submodule foreach --recursive 'git checkout -- . && git clean -fd'
git submodule update --init --recursive
```

檢查是否乾淨：`git -C ~/.local/share/nvim/lazy/LuaSnip submodule status`
（行首沒有 `+` / `-` 就表示正常）
