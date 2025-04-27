# Set Up

Please place this `nvim` folder inside

```
/home/tinymurky/.config
```

neovim will read it automatically

## Pre-install

Need to insatll `dcm` and `dart`

- ripgrep for tree
- dcm server please check [deb download linl](https://github.com/CQLabs/homebrew-dcm/releases) or check [dcm website](https://dcm.dev/docs/getting-started/installation/linux/?utm_source=chatgpt.com)
- dart can be install by flutter
- `wl-copy` in system for copy paste to clip board
- Use `:Mason` to insatll formatter (press `i`) and lint that been used in `none-ls`
- lazy git: https://github.com/jesseduffield/lazygit,
- https://www.youtube.com/watch?v=CPLdltN7wgE

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

> Telescope

- `<ctrl> + p`: 'Telescope find files'
- `<leader> + fg`: 'Telescope live grep'
- `<leader> + fg`: Telescope buffers'
- `<leader> + fg`: 'Telescope help tags'

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
