local map = vim.keymap.set
local opts = { silent = true, noremap = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Rebind 'Ctrl + U and Ctrl + D' to also re-center
map("n", "<C-u>", "<C-u>zz", { desc = "Move up half a page and re-center", remap = true })
map("n", "<C-d>", "<C-d>zz", { desc = "Move down half a page and re-center", remap = true })


map("n", "<Leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<Leader>/", "gc", { desc = "Toggle comment", remap = true })

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

map({ "v", "n", "x" }, "<leader>e", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "View file tree" })

-- Set 'b+c' to close all open tabs/buffers
vim.keymap.set("n", "<leader>bc", function()
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
            if not vim.api.nvim_buf_get_option(buf, "modified") then
                pcall(vim.api.nvim_buf_delete, buf, { force = false })
            end
        end
    end
end, { noremap = true, silent = true, desc = "Close all tabs" })

map("n", "dm", "<Cmd>delmarks!<CR>", { noremap = true, silent = true, desc = "Delete all marks" })

-- Fzf Lua
map(
    "n",
    "<leader>fw",
    '<Cmd>lua require("fzf-lua").live_grep_native()<CR>',
    { noremap = true, silent = true, desc = "Live grep" }
)
map(
    "n",
    "<leader>ff",
    '<Cmd>lua require("fzf-lua").files()<CR>',
    { noremap = true, silent = true, desc = "Find files" }
)
map(
    "n",
    "<leader>ft",
    '<Cmd>lua require("fzf-lua").treesitter()<CR>',
    { noremap = true, silent = true, desc = "Find symbols" }
)
map(
    "n",
    "<leader>fm",
    '<Cmd>lua require("fzf-lua").marks()<CR>',
    { noremap = true, silent = true, desc = "Find marks" }
)
map(
    "n",
    "<leader>fc",
    '<Cmd>lua require("fzf-lua").grep({ search="TODO|HACK|PERF|FIX|BUG", no_esc=true })<CR>',
    { noremap = true, silent = true, desc = "Find TODO (or similar) comments" }
)

-- Barbar bindings
map("n", "<Tab>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next tab" })
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true, desc = "Previous tab" })
map("n", "<space>x", "<Cmd>BufferClose<CR>", { noremap = true, silent = true, desc = "Close file" })

-- Git
map(
    "n",
    "<Space>gb",
    '<Cmd>lua require("gitsigns").blame_line({full = true})<CR>',
    { noremap = true, silent = true, desc = "Git blame current line" }
)
map("n", "<Space>gt", "<Cmd>GitBlameToggle<CR>", { noremap = true, silent = true, desc = "Toggle git blame" })

-- tmux navigator
map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Window Left" })
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Window Right" })
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Window Down" })
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Window Up" })

-- Conform
map("v", "<Leader>ff", "<Cmd>FormatRange<CR>", { desc = "Format selection", silent = true, noremap = true })
map(
    "n",
    "<Leader>cf",
    ':lua require("conform").format({ async = true, lsp_format = "fallback", lsp_fallback = true })<CR>',
    { desc = "Format file", silent = true, noremap = true }
)


map('n', '<Leader>dc', function()
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
    if #diagnostics > 0 then
        local message = diagnostics[1].message
        vim.fn.setreg("+", message)
        vim.notify("Copied: " .. message, vim.log.levels.INFO)
    else
        vim.notify("No diagnostics on current line", vim.log.levels.INFO)
    end
end, { desc = "Copy diagnostic to clipboard" })

-- Spectre
map("n", "<leader>S", '<Cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle spectre", silent = true, noremap = true })

-- Neotest
map("n", "<Leader>tt", '<Cmd>lua require("neotest").run.run()<CR>', { desc = "Run nearest test", silent = true, noremap = true })
map("n", "<Leader>tf", '<Cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { desc = "Run tests in current file", silent = true, noremap = true })
map("n", "<Leader>tc", '<Cmd>lua require("neotest").run.stop()<CR>', { desc = "Stop running test(s)", silent = true, noremap = true })
map("n", "<Leader>ts", '<Cmd>lua require("neotest").summary.toggle()<CR>', { desc = "View test summary", silent = true, noremap = true })
map("n", "<Leader>to", '<Cmd>lua require("neotest").output.open({ enter = true })<CR>', { desc = "View test output", silent = true, noremap = true })
