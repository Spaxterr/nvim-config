vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.tabufline_enabled = false

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

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

local cmp = require('cmp')

cmp.setup({
    enabled = false,  -- Disable nvim-cmp
})

vim.g.coc_global_extensions = {
    "coc-json",
    "coc-python",
    "coc-lua",
    "coc-tsserver",
    "coc-html",
    "coc-css",
    "coc-pyright",
    "coc-java",
    "coc-snippets",
    "coc-pairs",
    "coc-eslint",
    "coc-prettier",
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.schedule(function()
    require "mappings"
end)

