require "nvchad.options"

local o = vim.o

-- Map leader to '<Space>'
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

o.number = true             -- Show line numbers
o.relativenumber = true     -- Enable relative line numbers
o.tabstop = 4               -- Number of spaces a '<Tab>' displays as
o.shiftwidth = 4            -- Number of spaces to use for each step of indents when indenting lines with "Shift - >" or "Shift - <"
o.smartindent = true        -- Use smart indenting when inserting new lines
o.cmdheight = 2             -- Number of screen lines to use for the command-line
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
o.updatetime = 200          -- Update status line every 200ms

o.fileformats = "unix,dos,mac" -- Preserve file EOL character

-- WSL2 Clipboard fix
local is_wsl = vim.fn.has("wsl") == 1
if is_wsl then
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
            ["+"] = 'win32yank.exe -o --lf',
            ["*"] = 'win32yank.exe -o --lf'
        },
        cache_enabled = 0,
    }
end

-- Set color scheme
vim.cmd.colorscheme "catppuccin"
