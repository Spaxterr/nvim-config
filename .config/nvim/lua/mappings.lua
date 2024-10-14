require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Svart
map({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")
map({ "n", "x", "o" }, "S", "<Cmd>SvartRegex<CR>")
map({ "n", "x", "o" }, "gs", "<Cmd>SvartRepeat<CR>")

map("n", "<C-u>", "<C-u>zz", { desc = "Move up half a page and re-center", remap = true })
map("n", "<C-d>", "<C-d>zz", { desc = "Move down half a page and re-center", remap = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Neogen keybinds
map("n", "<Leader>cdf", ":lua require('neogen').generate({ type = 'func' })<CR>", { noremap = true, silent = true, desc = "Generate function docstring" })
map("n", "<Leader>cdc", ":lua require('neogen').generate({ type = 'class' })<CR>", { noremap = true, silent = true, desc = "Generate class docstring" })
map("n", "<Leader>cdt", ":lua require('neogen').generate({ type = 'type' })<CR>", { noremap = true, silent = true, desc = "Generate type docstring" })

-- Disable spacebar moving cursor as it is used as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', opts)

-- Formatter
map('v', '<Leader>ff', '<Plug>(coc-format-selected)', { desc = "Format selection" })

-- Clear whitespaces
map({'v', 'n'}, '<Leader>cw', [[:<C-u>'<,'>s/\s\+$//<CR>]], { noremap = true, silent = true, desc = "Remove trailing whitespaces" });
-- Add keybind to close all tabs
vim.api.nvim_set_keymap('n', '<leader>bc', ':bufdo bd<CR>', { noremap = true, silent = true, desc = "Close all tabs" })

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

map({ 'n', 'v' }, '<leader>cq', quickfix, { noremap = true, silent = true, desc = "Quickfix" })

map('n', '<leader>fw', "<CMD>lua require('telescope.builtin').live_grep({ debounce = 500 })<CR>", { noremap = true, silent = true, desc = "telescope live grep" })

-- Coc
map("n", "gd", "<Plug>(coc-definition)", opts)
map("n", "gy", "<Plug>(coc-type-definition)", opts)
map("n", "gi", "<Plug>(coc-implementation)", opts)
map("n", "gr", "<Plug>(coc-references)", opts)
map("n", "K", ":call CocActionAsync('doHover')<CR>", opts)
map("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], { noremap = true, silent = true, expr = true, })
map("i", "<Tab>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()', { noremap = true, expr = true, silent = true })
map("i", "<S-Tab>", 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', { noremap = true, expr = true, silent = true })

-- Barbar
map('n', '<Tab>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
map('n', '<space>x', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = "Close file" })

