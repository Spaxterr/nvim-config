require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Rebind 'Ctrl + U and Ctrl + D' to also re-center
map("n", "<C-u>", "<C-u>zz", { desc = "Move up half a page and re-center", remap = true })
map("n", "<C-d>", "<C-d>zz", { desc = "Move down half a page and re-center", remap = true })

-- Neogen
map(
    "n",
    "<Leader>cdf",
    ":lua require('neogen').generate({ type = 'func' })<CR>",
    { noremap = true, silent = true, desc = "Generate function docstring" }
)
map(
    "n",
    "<Leader>cdc",
    ":lua require('neogen').generate({ type = 'class' })<CR>",
    { noremap = true, silent = true, desc = "Generate class docstring" }
)
map(
    "n",
    "<Leader>cdt",
    ":lua require('neogen').generate({ type = 'type' })<CR>",
    { noremap = true, silent = true, desc = "Generate type docstring" }
)

-- Disable spacebar moving cursor as it is used as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { silent = true, noremap = true })

-- Set '<Space> + c + w' to clear trailing whitespace
map(
    { "v", "n" },
    "<Leader>cw",
    [[:<C-u>'<,'>s/\s\+$//<CR>]],
    { noremap = true, silent = true, desc = "Remove trailing whitespaces" }
)

-- Set 'b+c' to close all open tabs/buffers
vim.keymap.set('n', '<leader>bc', '<Cmd>CloseAllBuffers<CR>', { noremap = true, silent = true, desc = "Close all tabs" })

map("n", "dm", "<Cmd>delmarks!<CR>", { noremap = true, silent = true, desc = "Delete all marks" })

-- Fzf Lua
local fzf = require("fzf-lua")
map("n", "<leader>fw", fzf.live_grep_native, { noremap = true, silent = true, desc = "Live grep" })
map("n", "<leader>ff", fzf.files, { noremap = true, silent = true, desc = "Find files" })
map("n", "<leader>ft", fzf.treesitter, { noremap = true, silent = true, desc = "Find symbols" })
map("n", "<leader>fm", fzf.marks, { noremap = true, silent = true, desc = "Find marks" })

-- Barbar bindings
map("n", "<Tab>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next tab" })
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true, desc = "Previous tab" })
map("n", "<space>x", "<Cmd>BufferClose<CR>", { noremap = true, silent = true, desc = "Close file" })

-- Git
local gitsigns = require("gitsigns")
map("n", "<Space>gb", function()
    gitsigns.blame_line({ full = true })
end, { noremap = true, silent = true, desc = "Git blame current line" })
map("n", "<Space>gt", "<Cmd>GitBlameToggle<CR>", { noremap = true, silent = true, desc = "Toggle git blame" })

-- tmux navigator
map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Window Left" })
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Window Right" })
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Window Down" })
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Window Up" })

-- Conform
map("v", "<Leader>ff", "<Cmd>Format<CR>", { desc = "Format selection", silent = true, noremap = true })
map(
    "n",
    "<Leader>cf",
    ':lua require("conform").format({ async = true, lsp_format = "fallback", lsp_fallback = true })<CR>',
    { desc = "Format file", silent = true, noremap = true }
)
