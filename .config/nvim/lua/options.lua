require "nvchad.options"

local is_wsl = vim.fn.has("wsl") == 1
local o = vim.o

vim.g.mapleader = " "

vim.opt.list = true
vim.opt.listchars = { trail = '·' }

vim.diagnostic.config({
    virtual_text = {
        prefix = "",
        spacing = 4,
    },
    float = {
        source = "always",
        border = "rounded"
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

o.number = true -- Show line numbers
o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.cmdheight = 2
o.expandtab = true
o.autoindent = true
o.signcolumn = 'yes'
o.breakindent = true
o.wrap = false

o.mouse = "" -- Disable mouse
o.termguicolors = true

o.clipboard = "unnamedplus"
o.incsearch = true

o.ignorecase = true
o.smartcase = true

o.hlsearch = true
o.lazyredraw = true
o.updatetime = 300
o.timeoutlen = 500
o.ttimeoutlen = 0
o.autowrite = false
o.visualbell = true
o.timeoutlen = 50

o.undofile = true
o.updatetime = 200

if is_wsl then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))'
        },
        cache_enabled = 0,
    }
end

vim.cmd.colorscheme "catppuccin"

