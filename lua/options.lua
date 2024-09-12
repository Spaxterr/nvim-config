require "nvchad.options"

-- add yours here!
local is_wsl = vim.fn.has("wsl") == 1
local o = vim.o

o.number = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.autoindent = true
o.breakindent = true

o.mouse = "a"
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

