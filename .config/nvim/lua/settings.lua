local o = vim.o

vim.opt.maxmempattern = 2000000

-- Map leader to '<Space>'
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.conceallevel = 2
vim.opt.list = true
vim.opt.listchars = { trail = '·', tab = '  ' }

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.svelte_preprocessors = { "typescript" }

vim.uv.os_setenv("JAVA_HOME",  "/usr/lib/jvm/java-21-openjdk-amd64")

vim.diagnostic.config({
    virtual_text = false,
    float = {
        source = "always",
        border = "rounded",
        header = "",
        prefix = "",
        borderhighlight = "Comment",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
                "WinLeave",
            },
        })
    end
})

o.number = true             -- Show line numbers
o.relativenumber = true     -- Enable relative line numbers
o.tabstop = 4               -- Number of spaces a '<Tab>' displays as
o.shiftwidth = 4            -- Number of spaces to use for each step of indents when indenting lines with the ">" or "<" keys
o.smartindent = true        -- Use smart indenting when inserting new lines
o.cmdheight = 1             -- Number of screen lines to use for the command-line
o.expandtab = true          -- Use appropriate number of spaces when inserting a <Tab>
o.autoindent = true         -- Copy indentation of current line when inserting a new line
o.signcolumn = 'yes'        -- Display icons in the line number column for e.g. warnings or errors
o.wrap = false              -- Disable line wrapping

o.mouse = ""                -- Disable mouse
o.scrolloff = 10            -- Make sure at least 10 lines are always showing above and below the cursor
o.termguicolors = true      -- Enable 24-bit colors

o.clipboard = "unnamedplus" -- Sync OS clipboard with Neovim clipboard
o.incsearch = true          -- Enable incremental search

o.ignorecase = true         -- Ignore case when searching
o.smartcase = true          -- If capital letters appear in search, enable case sensitivity

o.hlsearch = true           -- Highlight search matches
o.lazyredraw = true         -- Lazy redrawing
o.timeoutlen = 2500         -- Show 'whichkey' after 2.5s
o.ttimeoutlen = 0           -- Keycode timeout
o.autowrite = false         -- Disable auto-saving of files
o.visualbell = true         -- Use visual bell instead of OS 'beeping' on error input

o.undofile = true           -- Enable undoing
o.updatetime = 250          -- Update status line every 250ms

o.fileformats = "unix,dos,mac" -- Preserve file EOL character

-- WSL2 Clipboard fix
local is_wsl = vim.fn.has("wsl") == 1
if is_wsl then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] =
            'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] =
            'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

