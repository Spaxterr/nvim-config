vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46/"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.tabufline_enabled = false

vim.g.svelte_preprocessors = { "typescript" }

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

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

require("configs.lspconfig")
require("options")
require("nvchad.autocmds")
require("autocmds")

vim.schedule(function()
    require("mappings")
end)

local function close_all_buffers()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(bufnr) and not vim.bo[bufnr].modified then
            vim.cmd("bdelete " .. bufnr)
        end
    end
end

vim.api.nvim_create_user_command("CloseAllBuffers", function()
    pcall(close_all_buffers)
end, {})

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ async = true, lsp_format = "fallback", range = range, lsp_fallback = true })
end, { range = true })

--
vim.cmd([[highlight! link MiniTrailspace Search ]])

-- Set highlight colors for notifier
vim.cmd([[
    highlight NotifyERRORBorder guifg=#e78284
    highlight NotifyWARNBorder guifg=#e5c890
    highlight NotifyINFOBorder guifg=#99d1db
    highlight NotifyDEBUGBorder guifg=#f4b8e4
    highlight NotifyTRACEBorder guifg=#c6d0f5
]])
