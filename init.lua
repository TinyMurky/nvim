-- Tudorial:
-- https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn

-- package manager has two kind
-- package.nvim
-- lazy.nvim (lazy.folke.io/installation)
-- below install lazy.nvim if not yet installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- check if lazy installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- vim tweak, vim key bind
require("vim-options")
-- Load Lazy
-- package in plugins will be download, but neet to use require mannually
require("lazy").setup("plugins") -- plugins.lua
