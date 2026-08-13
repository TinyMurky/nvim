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

> Buffer 分頁列（barbar.nvim）

畫面最上方那條分頁列，把開著的 buffer 用類似 VS Code 的樣式排在頂端，
帶檔案圖示（nvim-web-devicons）和 git 狀態標記（gitsigns.nvim）。
設定在 `lua/plugins/tab.lua`。

| Key | Action |
| --- | --- |
| `<A-,>` | 上一個分頁 (`BufferPrevious`) |
| `<A-.>` | 下一個分頁 (`BufferNext`) |
| `<A-<>` | 把目前分頁往左移 (`BufferMovePrevious`) |
| `<A->>` | 把目前分頁往右移 (`BufferMoveNext`) |
| `<A-c>` | 關掉目前分頁 (`BufferClose`) |

> ⚠️ `tab.lua` 裡釘了 `version = '^1.0.0'`，lazy 只會更新到 1.x。
> 上游若把修正發在 2.x，不會自動拿到。
>
> 啟動時 `v:errmsg` 會留下 `E116: Invalid arguments for function dictwatcherdel`。
> **這是正常的，不用修** —— barbar 首次啟動會「試著刪掉一個還不存在的 watcher」，
> 原始碼裡用 `silent!` 包著表示預期會失敗（`autoload/barbar/events.vim`）。
> 畫面上看不到，功能也完全正常。0.11 一樣會有，跟 Neovim 版本無關。

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
| `:call mkdp#util#install()` | 手動下載預覽用的 binary（預覽開不起來時用） |

### 預覽是空白的 / 瀏覽器開了但沒內容

多半是 binary 沒裝成功（lazy 的 build 靜靜失敗了）。先檢查：

```bash
ls ~/.local/share/nvim/lazy/markdown-preview.nvim/app/bin/
```

要看到 `markdown-preview-linux`。沒有的話直接跑安裝腳本（比 `:call mkdp#util#install()` 可靠，
會顯示下載進度）：

```bash
cd ~/.local/share/nvim/lazy/markdown-preview.nvim && bash app/install.sh
```

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

---

## 升級 Neovim（AppImage）

### 現況

Neovim 是用 AppImage 裝的，不是 apt / snap：

```
~/.local/bin/nvim  ->  ~/nvim/nvim-linux-x86_64.appimage      (目前 = 0.12.4)
                       ~/nvim/nvim-linux-x86_64_11.appimage   (保留的 0.11.1，回退用)
```

因為是 symlink，**升級與回退都只是換 symlink 指向**，這是最安全的形式。
前提是：**舊的 appimage 不要刪掉**。

### 升級步驟

1. 先記下現在的版本，並把舊檔改成帶版號的名字（方便日後回退）：

    ```bash
    nvim --version | head -1          # 例如 NVIM v0.11.1
    mv ~/nvim/nvim-linux-x86_64.appimage ~/nvim/nvim-0.11.1.appimage
    ln -sf ~/nvim/nvim-0.11.1.appimage ~/.local/bin/nvim   # symlink 先指回舊版
    ```

2. 下載新版（`stable` 會拿到最新穩定版；要釘版本就把 `stable` 換成 `v0.12.4`）：

    ```bash
    cd ~/nvim
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
    chmod +x nvim-linux-x86_64.appimage
    ./nvim-linux-x86_64.appimage --version | head -1      # 確認版本
    mv nvim-linux-x86_64.appimage nvim-0.12.4.appimage    # 改成實際版號
    ```

3. 切換過去：

    ```bash
    ln -sf ~/nvim/nvim-0.12.4.appimage ~/.local/bin/nvim
    nvim --version | head -1
    ```

4. 升級後第一次開 nvim 要做的事：

    ```vim
    :Lazy sync
    :TSUpdate          " treesitter parser 綁 ABI 版本，跨大版本要重編
    :checkhealth
    ```

    > **跨大版本（例如 0.11 → 0.12）光做這步不夠**，treesitter 需要換分支，
    > 見下面的〈0.11 → 0.12 完整升級流程〉。

### 回退

symlink 指回去就好，一秒完成：

```bash
ln -sf ~/nvim/nvim-linux-x86_64_11.appimage ~/.local/bin/nvim
```

⚠️ **光是換回舊 appimage 不夠** —— 這份 config 目前有幾個檔案是 0.12 專屬的，
在 0.11 上會直接讓 nvim 開不起來：

| 檔案 | 0.11 沒有的東西 |
| --- | --- |
| `lua/ui-setting.lua` | `'pumborder'` 選項 → `E5113: Unknown option 'pumborder'` |
| `lua/completion.lua` | `'autocomplete'` 選項、`wildtrigger()` |
| `lua/plugins/treesitter.lua` | nvim-treesitter `main` 分支要求 0.12+ |

所以回退要連同這些檔案一起還原：

```bash
cd ~/.config/nvim
git checkout bd9ff00 -- \
    lua/plugins/treesitter.lua \
    lua/ui-setting.lua \
    lua/plugins/completions.lua \
    lua/utils/lsp_capabilities.lua \
    lua/plugins/lsp-config.lua \
    init.lua
rm -f lua/completion.lua
```

`bd9ff00`（修好 markdown preview）是升級前的最後一個 commit。升級相關的兩個是
`39d7b60`（升級到 Neovim 0.12）和 `ea1a408`（改用原生補全）。

還原之後 treesitter 的 parser 也要重裝（`main` 和 `master` 的安裝目錄不同）：
在 0.11 裡跑 `:Lazy sync` 然後 `:TSUpdate`。

### 0.11 → 0.12 完整升級流程

> 這是 2026-08-13 實際做過一次的紀錄，照著跑即可。

**Step 1 — 先在 0.11 上修掉 deprecation**（改完 0.11 / 0.12 都相容，零風險）

- `lua/utils/error_jump.lua`：`vim.diagnostic.goto_next/goto_prev` → `vim.diagnostic.jump()`
  - `jump()` 會回傳「有沒有找到」，不用再比對游標位置
  - 要明確帶 `float = true`，`goto_next` 預設會彈浮窗但 `jump()` 預設不會
- `init.lua`：`vim.diagnostic.config` 的 `float.source` 從 `"always"` 改成 `true`

**Step 2 — 換 appimage**（見上面的〈升級步驟〉）

**Step 3 — 裝 `tree-sitter` CLI**

0.12 一定要換到 nvim-treesitter 的 `main` 分支，而 `main` 用 `tree-sitter` CLI 來 build
parser。Ubuntu 22.04 不能用預編譯 binary（glibc 太舊），要自己編：

```bash
sudo apt install -y libclang-dev
cargo install tree-sitter-cli --locked
tree-sitter --version                   # 要 >= 0.26.1
```

細節與各種錯誤訊息見〈nvim-treesitter（`main` 分支）〉那一節。

**Step 4 — 換 nvim-treesitter 分支並清掉舊 parser**

`lua/plugins/treesitter.lua` 改成 `branch = "main"` 版本，然後清掉 master 留下的
舊 parser（ABI 不合，留著會繼續作亂）：

```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter/parser \
       ~/.local/share/nvim/lazy/nvim-treesitter/parser-info
```

**Step 5 — 重裝 plugin 與 parser**

```vim
:Lazy sync
:TSUpdate
```

**Step 6 — 驗證**

```vim
:checkhealth
```

開幾個不同語言的檔案，確認有語法上色。快速檢查已安裝的 parser：

```bash
ls ~/.local/share/nvim/site/parser/
```

應該看到 `go.so dart.so javascript.so lua.so markdown.so markdown_inline.so
python.so rust.so tsx.so typescript.so yaml.so`（注意路徑是 `site/`，
不再是外掛資料夾裡）。

**Step 7 — 觀察幾天**

`vim.NIL` 那類 LSP 改動只有實際用才會踩到，舊 appimage 先別刪。

### 0.12 升級注意事項

這個 config 已經處理好的部分：

- LSP 已經用原生的 `vim.lsp.config()` / `vim.lsp.enable()`（不是舊的
  `require('lspconfig').xxx.setup{}`），這是 0.11→0.12 最大的一筆遷移
- mason-lspconfig 已經是 v2（`automatic_enable`）
- `vim.diagnostic.goto_next/goto_prev` 已改成 `vim.diagnostic.jump()`
- `vim.diagnostic.config` 的 `float.source` 已從 `"always"` 改成 `true`

**看起來危險但沒事**：`debugging.lua` 裡的 `vim.fn.sign_define('DapBreakpoint', ...)`。
0.12 的 breaking change 只針對 **diagnostic** signs（`DiagnosticSignError` 那一組），
nvim-dap 自己的 sign group 不受影響。

**0.12 反而修掉的**：go.nvim 的 `vim.lsp.condelens` typo（`lua/go/lsp.lua:47`）。
0.11 沒有 `vim.lsp.codelens.enable`，所以會走進那個壞掉的 else 分支噴
`ON_ATTACH_ERROR`；0.12 有了 `.enable`，會走正常分支，問題自動消失。

**真正的風險在 plugin 端，靜態掃不出來**，只能升上去實際跑：

- LSP 的 JSON `null` 從 `nil` 改成 `vim.NIL` ← 最容易讓 plugin 出錯
- `client.attached_buffers[buf]` 從 boolean 變成 languageId 字串
- `vim.lsp.semantic_tokens.start/stop` 改名成 `enable()`

會受影響的是那些自己處理 LSP 回應的外掛：**go.nvim / rustaceanvim /
flutter-tools / none-ls**。出事就用上面的回退指令切回舊版。

**nvim-treesitter 必須換到 `main` 分支** — 見下一節。

---

## nvim-treesitter（`main` 分支）

### 為什麼不能用 master

升上 0.12 之後，開 markdown 會噴：

```
vim/treesitter.lua:197: attempt to call method 'range' (a nil value)
  ... nvim-treesitter/lua/nvim-treesitter/query_predicates.lua:141: in function 'handler'
```

0.12 移除了 `Query:iter_matches()` 的 `all` 選項，`match[capture_id]` 現在一律是
`TSNode[]` 陣列而不是單一 node。master 的 `query_predicates.lua` 還當成單一 node
在用，所以拿到 table 再呼叫 `:range()` 就爆了。

**這不會被修**。master 的最後一個 commit 就是把 README 改成：

```diff
- **Neovim 0.10** or later (supported up to Neovim 0.12);
+ **Neovim 0.10 or 0.11** (Neovim 0.12 is **not supported**);
```

### 為什麼不能直接拔掉改用 core 原生

Neovim 0.12 的 core 只涵蓋一部分：

| 功能 | core 0.12 |
| --- | --- |
| Highlight (`vim.treesitter.start`) | ✅ 原生 |
| Fold (`vim.treesitter.foldexpr`) | ✅ 原生 |
| 內建 parser | ⚠️ 只有 `c lua markdown markdown_inline query vim vimdoc` |
| go / rust / python / typescript / tsx / javascript / yaml / dart | ❌ 沒有 |
| parser 安裝器（`:TSInstall` / `:TSUpdate`） | ❌ 沒有 |
| Indent（`vim.treesitter.indentexpr`） | ❌ 沒有（是 nil） |

所以 parser 管理跟 indent 還是得靠 nvim-treesitter。

### Pre-install：`tree-sitter` CLI（**必要**）

`main` 分支跟 master 不同，它用 **`tree-sitter` CLI** 來 build parser，不是直接用 `cc`。
沒有這個 CLI 的話所有 parser 都會失敗（而且訊息會騙你說 `Installed 13/13 languages`，
其實只裝到 `jsx` / `ecma` 這兩個不用編譯的別名）。

上游要求 **0.26.1 以上，用套件管理器裝，不要用 npm**。

⚠️ **Ubuntu 22.04（glibc 2.35）不能用預編譯 binary**。Mason 的 `tree-sitter-cli`
和 npm 套件裝的都是同一批預編譯檔，需要 GLIBC 2.39，會噴：

```
tree-sitter: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.39' not found
```

**用 cargo 從原始碼編**（對著本機 glibc 編，這是這台機器唯一可行的方式）：

```bash
sudo apt install -y libclang-dev        # 先裝這個，否則下一步會失敗
cargo install tree-sitter-cli --locked
tree-sitter --version                   # 要 >= 0.26.1
```

`libclang-dev` 是必要的 —— tree-sitter 0.26 的相依會用 bindgen，少了它會噴：

```
Unable to find libclang: couldn't find any valid shared libraries matching:
['libclang.so', 'libclang-*.so', ...]
```

> 如果之前用 Mason 裝過，記得先移掉（`:Mason` 找到 tree-sitter-cli 按 `X`）。
> Mason 的 bin 目錄在 nvim 的 PATH 裡優先權比 `~/.cargo/bin` 高，
> 壞掉的那個會蓋掉 cargo 編出來的。

### 設定上的差異

`main` 沒有 `require('nvim-treesitter.configs').setup()`。`lua/plugins/treesitter.lua`
改成自己掛 FileType autocmd：

- highlight → `vim.treesitter.start()`
- indent → `vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"`
- parser 安裝目錄從外掛資料夾改到 `stdpath('data')/site`

要加語言就改檔案裡的 `ensure_installed`，或直接 `:TSInstall <lang>`。

### 常用指令

| Command | Description |
| ------- | ----------- |
| `:TSInstall <lang>` | 安裝某個語言的 parser |
| `:TSUpdate` | 更新所有已安裝的 parser |
| `:checkhealth vim.treesitter` | 檢查 parser 狀態 |

### 疑難排解

`:TSUpdate` 全部失敗、或開檔案沒有語法上色：

```bash
tree-sitter --version                                  # 沒有這個指令 → 見上面 Pre-install
ls ~/.local/share/nvim/site/parser/                    # 應該看到 go.so / rust.so ...
```

從 master 換過來時，舊 parser 留在外掛資料夾裡會因為 ABI 不合而繼續作亂，要清掉：

```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter/parser \
       ~/.local/share/nvim/lazy/nvim-treesitter/parser-info
```

---

## 補全（Neovim 0.12 原生，取代 nvim-cmp）

設定在 `lua/completion.lua`（由 `init.lua` require），視窗外觀在 `lua/ui-setting.lua`。

舊的 nvim-cmp 設定**沒有刪掉**，留在 `lua/plugins/completions.lua` 裡用
`enabled = false` 關著，方便隨時退回。

### cmp → 原生 對照表

| 原本 nvim-cmp | 現在 |
| --- | --- |
| `cmp.config.window.bordered()` | `'pumborder'` 選項 |
| `sources = { nvim_lsp }` | `'complete'` 的 `o` 旗標（omnifunc = LSP） |
| `sources = { buffer }` | `'complete'` 的 `.` `w` `b` 旗標 |
| 自動跳出選單 | `'autocomplete'` 選項 |
| `cmp.setup.cmdline({'/', '?'})` | `wildtrigger()` + `wildoptions=pum` |
| `cmp_nvim_lsp.default_capabilities()` | `vim.lsp.protocol.make_client_capabilities()` |

`'complete'` 設成 `.,w,b,o`：目前 buffer → 其他視窗 → 其他已載入 buffer → LSP。
順序有意義，越前面的來源分到越多運算時間。

### Keymaps

| 按鍵 | 行為 |
| --- | --- |
| `<C-j>` / `<C-k>` | 上下選（跟 smart-splits 的視窗跳躍同一組手指） |
| `<Down>` / `<Up>` | 上下選（**原生就支援，不用設定**） |
| `<C-n>` / `<C-p>` | 上下選（Vim 內建，會邊移邊把候選字塞進 buffer） |
| `<Tab>` | 選單開著→確認；snippet 展開中→跳下一格；否則→普通 Tab |
| `<S-Tab>` | 上一項 / snippet 往回跳 |
| `<C-Space>` | 手動觸發 LSP 補全 |
| `<C-e>` | 取消（原生預設） |
| `<C-y>` | 確認（原生預設，`<Tab>` 是它的別名） |

> `<C-j>` / `<C-k>` **只在選單開著時**才攔截；沒開選單就原樣放行，
> 所以 `i_CTRL-J`（換行）和 `i_CTRL-K`（輸入 digraph，例如 `<C-k>a:` 打出 `ä`）
> 的預設行為都保留。跟 smart-splits 的 `<C-j>` / `<C-k>` 也不衝突 —— 那組是 normal mode。
>
> `<C-n>` / `<C-p>` 沒有拿掉：它們不是設定裡綁的快捷鍵，而是 **Vim 內建的補全機制本身**
> （`i_CTRL-N` = keyword completion）。留著成本是零，還多一層後路。
>
> 三組的差別：`<C-j>` / `<C-k>` 與方向鍵**只移動選取**，`<C-n>` 會邊移邊把候選字寫進 buffer。
> 因為 `completeopt` 有 `noselect`（不預選），看清楚再按 `<Tab>` 確認會比較順。

### 換過來之後少了什麼

- **friendly-snippets** — 那是 vscode 格式的獨立 snippet 集，原生補全沒有對應來源。
  **LSP server 自己提供的 snippet 仍然正常展開**（走 `vim.snippet`），
  所以 Go / Rust / TS 的補全體驗不受影響，少的是手打縮寫展開模板那種。
- **`<C-b>` / `<C-f>` 捲動說明浮窗** — 文件仍會顯示（`completeopt` 有 `popup`），只是不能捲。

### 說明浮窗的邊框（workaround）

`completeopt=popup` 的說明浮窗，其 border 在 Neovim 內部**被寫死成 `"none"`**，
`'pumborder'` 只作用在選單本身，`'winborder'` 也管不到它。

`lua/completion.lua` 裡用一個 `CompleteChanged` autocmd 在事後補上 `rounded`。
判斷條件刻意挑得很嚴（非目前視窗 + 浮動 + 不可聚焦 + border 是 none +
無名的 `nofile` buffer），實測過只會命中說明浮窗，不會動到 ui2 的訊息視窗。

如果哪天上游自己加了對應選項、或行為改變，這段 autocmd 頂多是找不到目標而沒作用，
不會出錯。不想要邊框就把那個 autocmd 註解掉。

### 回退成 nvim-cmp

1. `lua/plugins/completions.lua` 開頭的 `ENABLED` 改成 `true`
2. `init.lua` 註解掉 `require("completion")`
3. `lua/utils/lsp_capabilities.lua` 改回 `require('cmp_nvim_lsp').default_capabilities(...)`
4. `lua/plugins/lsp-config.lua` 的 `dependencies` 加回 `"hrsh7th/cmp-nvim-lsp"`
5. `:Lazy sync`

### ui2（訊息與 cmdline UI 重新設計）

在 `lua/ui-setting.lua` 啟用：

```lua
pcall(function() require("vim._core.ui2").enable() end)
```

最大好處是**不會再被 `Press ENTER or type command to continue` 打斷**，
訊息改用浮動視窗顯示，cmdline 也會即時上色。

還是實驗性的，所以模組路徑帶底線（`vim._core`），未來可能改名 ——
用 `pcall` 包起來，哪天上游搬走也只是靜靜地退回舊 UI，不會讓整個 config 開不起來。
