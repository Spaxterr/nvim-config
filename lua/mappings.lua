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

