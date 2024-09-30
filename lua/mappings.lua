require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

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
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Add keybind to close all tabs
vim.api.nvim_set_keymap('n', '<leader>bc', ':bufdo bd<CR>', { noremap = true, silent = true, desc = "Close all tabs" })

map('v', '<Leader>ff', vim.lsp.buf.format, { desc = "Format selection" })

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

map({ 'n', 'v' }, '<leader>cq', quickfix, { noremap = true, silent = true, desc = "Quickfix" })

map('n', '<leader>fw', "<CMD>lua require('telescope.builtin').live_grep({ debounce = 250 })<CR>", { noremap = true, silent = true, desc = "telescope live grep" })

