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

## Unit test with [gotests](https://github.com/cweill/gotests) and testify

> Ref [go.nvim](https://github.com/ray-x/go.nvim)

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
