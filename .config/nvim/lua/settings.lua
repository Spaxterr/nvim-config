local o = vim.o

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.tabclose = "uselast"
vim.opt.maxmempattern = 2000000
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Map leader to '<Space>'
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.conceallevel = 2
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "  " }

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.svelte_preprocessors = { "typescript" }

vim.diagnostic.config({
    virtual_text = false,
    source = true,
    float = {
        border = "single",
        header = "",
        prefix = "",
        borderhighlight = "Comment",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

o.number = true                -- Show line numbers
o.relativenumber = true        -- Enable relative line numbers
o.tabstop = 4                  -- Number of spaces a '<Tab>' displays as
o.shiftwidth = 4               -- Number of spaces to use for each step of indents when indenting lines with the ">" or "<" keys
o.smartindent = true           -- Use smart indenting when inserting new lines
o.cmdheight = 1                -- Number of screen lines to use for the command-line
o.expandtab = true             -- Use appropriate number of spaces when inserting a <Tab>
o.autoindent = true            -- Copy indentation of current line when inserting a new line
o.signcolumn = "yes"           -- Display icons in the line number column for e.g. warnings or errors
o.wrap = false                 -- Disable line wrapping

o.mouse = ""                   -- Disable mouse
o.scrolloff = 10               -- Make sure at least 10 lines are always showing above and below the cursor
o.termguicolors = true         -- Enable 24-bit colors

o.incsearch = true             -- Enable incremental search

o.ignorecase = true            -- Ignore case when searching
o.smartcase = true             -- If capital letters appear in search, enable case sensitivity

o.hlsearch = true              -- Highlight search matches
-- o.lazyredraw = true      -- Disabled: only affects macros, can cause visual glitches
o.timeoutlen = 400             -- Show 'whichkey' after 400ms
o.ttimeoutlen = 0              -- Keycode timeout
o.autowrite = false            -- Disable auto-saving of files
o.visualbell = true            -- Use visual bell instead of OS 'beeping' on error input

o.undofile = true              -- Enable undoing
o.updatetime = 250             -- Update status line every 250ms

o.fileformats = "unix,dos,mac" -- Preserve file EOL character

-- Lazy load clipboard provider to speed up startup on WSL
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    once = true,
    callback = function()
        if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
            vim.g.clipboard = {
                name = "WslClipboard",
                copy = {
                    ["+"] = "/mnt/c/Windows/System32/clip.exe",
                    ["*"] = "/mnt/c/Windows/System32/clip.exe",
                },
                paste = {
                    ["+"] =
                    '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                    ["*"] =
                    '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                },
                cache_enabled = 0,
            }
        elseif vim.fn.has("unix") == 1 then
            if vim.env.TMUX and vim.fn.executable("tmux") == 1 then
                vim.g.clipboard = {
                    name = "tmux-wl-paste",
                    -- Use tmux for copying since it doesn't have any issues with window focus
                    copy = {
                        ["+"] = { "tmux", "load-buffer", "-w", "-" },
                        ["*"] = { "tmux", "load-buffer", "-w", "-" },
                    },
                    -- Use wl-paste for pasting to retain OS passthrough
                    paste = {
                        ["+"] = { "wl-paste", "--no-newline" },
                        ["*"] = { "wl-paste", "--no-newline", "--primary" },
                    },
                    cache_enabled = 1,
                }
            elseif vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1 then
                vim.g.clipboard = {
                    name = "wl-clipboard",
                    copy = {
                        ["+"] = { "wl-copy", "--type", "text/plain" },
                        ["*"] = { "wl-copy", "--primary", "--type", "text/plain" },
                    },
                    paste = {
                        ["+"] = { "wl-paste", "--no-newline" },
                        ["*"] = { "wl-paste", "--no-newline", "--primary" },
                    },
                    cache_enabled = 1,
                }
            elseif vim.fn.executable("xclip") == 1 then
                vim.g.clipboard = {
                    copy = {
                        ["+"] = "xclip -selection clipboard",
                        ["*"] = "xclip -selection clipboard",
                    },
                    paste = {
                        ["+"] = "xclip -selection clipboard -o",
                        ["*"] = "xclip -selection clipboard -o",
                    },
                }
            elseif vim.fn.executable("xsel") == 1 then
                vim.g.clipboard = {
                    copy = {
                        ["+"] = "xsel --clipboard --input",
                        ["*"] = "xsel --clipboard --input",
                    },
                    paste = {
                        ["+"] = "xsel --clipboard --output",
                        ["*"] = "xsel --clipboard --output",
                    },
                }
            end
        end

        vim.opt.clipboard = "unnamedplus"
    end,
    desc = "Lazy load clipboard",
})
