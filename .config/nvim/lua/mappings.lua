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

-- Fzf Lua
local fzf = require("fzf-lua")
map("n", "<leader>fw", fzf.live_grep, { noremap = true, silent = true, desc = "Live grep" })
map("n", "<leader>ff", fzf.files, { noremap = true, silent = true, desc = "Find files" })
map("n", "<leader>ft", fzf.treesitter, { noremap = true, silent = true, desc = "Find symbols" })

-- Coc bindings
map("n", "<Leader>cr", "<Plug>(coc-rename)", { desc = "Rename symbol", silent = true, noremap = true })
map("i", "<C-s>", "coc#refresh()", { desc = "Show completions", silent = true, expr = true, noremap = true })
map("n", "gd", "<Plug>(coc-definition)", { silent = true, desc = "Go to definition" })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true, desc = "Go to type definition" })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true, desc = "Go to implementation" })
map("n", "gr", "<Plug>(coc-references)", { silent = true, desc = "Go to reference(s)" })
map({ "v", "n", "x" }, "<leader>cq", "<Plug>(coc-codeaction-cursor)", { silent = true, desc = "Show code actions" })
map("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true, desc = "Hover" })
map(
    "i",
    "<CR>",
    [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
    { noremap = true, silent = true, expr = true }
)
map("i", "<C-j>", 'coc#pum#visible() ? coc#pum#next(1) : "<C-j>"', { noremap = true, expr = true, silent = true })
map("i", "<C-k>", 'coc#pum#visible() ? coc#pum#prev(1) : "<C-k>"', { noremap = true, expr = true, silent = true })

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
