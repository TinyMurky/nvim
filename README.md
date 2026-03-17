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
