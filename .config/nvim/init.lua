vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.tabufline_enabled = false

-- vim.g.coc_global_extensions = require('configs.coc-languages')
vim.g.svelte_preprocessors = {'typescript'}

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

local cmp = require('cmp')
cmp.setup({
    enabled = false,  -- Disable nvim-cmp since coc already has autocompletion
})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Set inline hints to the same color as LineNr
vim.cmd [[highlight! link CocInlayHint LineNr ]]

