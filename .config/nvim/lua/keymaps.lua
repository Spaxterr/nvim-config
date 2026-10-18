local function map(mode, lhs, rhs, desc, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { silent = true, desc = desc }, opts or {}))
end

-- Disable spacebar moving cursor as it is used as leader key
map("", "<Space>", "<Nop>")

map("n", ";", ":", "CMD enter command mode", { silent = false })
map("i", "jk", "<Esc>")
map("n", "<Esc>", "<Cmd>nohlsearch<CR>", "Clear search highlight")

map("n", "<C-u>", "<C-u>zz", "Move up half a page and re-center", { remap = true })
map("n", "<C-d>", "<C-d>zz", "Move down half a page and re-center", { remap = true })

map("n", "<Leader>/", "gcc", "Toggle comment", { remap = true })
map("v", "<Leader>/", "gc", "Toggle comment", { remap = true })

-- Neogen
map("n", "<Leader>cdf", function() require("neogen").generate({ type = "func" }) end, "Generate function docstring")
map("n", "<Leader>cdc", function() require("neogen").generate({ type = "class" }) end, "Generate class docstring")
map("n", "<Leader>cdt", function() require("neogen").generate({ type = "type" }) end, "Generate type docstring")

map("n", "<Leader>cw", "<Cmd>%s/\\s\\+$//e<CR>", "Remove trailing whitespaces")
map("v", "<Leader>cw", ":s/\\s\\+$//e<CR>", "Remove trailing whitespaces")

map({ "n", "x" }, "<Leader>e", "<Cmd>NvimTreeToggle<CR>", "View file tree")

-- Marks (uppercase for cross-file support)
map("n", "mm", function()
    for i = 65, 90 do -- A-Z
        local letter = string.char(i)
        if vim.api.nvim_get_mark(letter, {})[1] == 0 then
            vim.cmd("mark " .. letter)
            return
        end
    end
    vim.notify("All marks A-Z are used", vim.log.levels.WARN)
end, "Auto-place next available mark")

map("n", "md", function()
    local buf = vim.api.nvim_get_current_buf()
    local cursor_line = vim.fn.line(".")
    local file = vim.api.nvim_buf_get_name(buf)

    for i = 65, 90 do
        local letter = string.char(i)
        local mark = vim.api.nvim_get_mark(letter, {})
        if mark[1] == cursor_line and mark[4] == file then
            vim.cmd("delmarks " .. letter)
            return
        end
    end

    for i = 97, 122 do
        local letter = string.char(i)
        if vim.api.nvim_buf_get_mark(buf, letter)[1] == cursor_line then
            vim.cmd("delmarks " .. letter)
            return
        end
    end
    vim.notify("No mark on current line", vim.log.levels.INFO)
end, "Delete mark on current line")

map("n", "dm", "<Cmd>delmarks!<CR><Cmd>delmarks A-Z<CR>", "Delete all marks")

map("n", "gm", function()
    local char = vim.fn.getcharstr()
    if char:match("[a-zA-Z]") then
        vim.cmd("normal! `" .. char)
    end
end, "Go to mark")

-- Fzf Lua
map("n", "<Leader>fw", function() require("fzf-lua").live_grep_native() end, "Live grep")
map("n", "<Leader>ff", function() require("fzf-lua").files() end, "Find files")
map("n", "<Leader>ft", function() require("fzf-lua").treesitter() end, "Find symbols")
map("n", "<Leader>fm", function() require("fzf-lua").marks() end, "Find marks")
map("n", "<Leader>fc", function()
    require("fzf-lua").grep({ search = "TODO|HACK|PERF|FIX|BUG", no_esc = true })
end, "Find TODO (or similar) comments")

-- Buffers
map("n", "<Tab>", "<Cmd>BufferNext<CR>", "Next tab")
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", "Previous tab")
map("n", "<Leader>x", "<Cmd>BufferClose<CR>", "Close file")
map("n", "<Leader>bc", "<Cmd>%bd|e#<CR>", "Close all tabs")

-- Git
map("n", "<Leader>gb", function() require("gitsigns").blame_line({ full = true }) end, "Git blame current line")
map("n", "<Leader>gt", function() require("gitsigns").toggle_current_line_blame() end, "Toggle git blame")

-- tmux navigator
map("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", "Window Left")
map("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", "Window Right")
map("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", "Window Down")
map("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", "Window Up")

-- Conform (formats the selection in visual mode)
map({ "n", "v" }, "<Leader>cf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, "Format file")
map("v", "<Leader>ff", "<Cmd>FormatRange<CR>", "Format selection")

map("n", "<Leader>dc", function()
    local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
    if #diagnostics > 0 then
        vim.fn.setreg("+", diagnostics[1].message)
        vim.notify("Copied: " .. diagnostics[1].message, vim.log.levels.INFO)
    else
        vim.notify("No diagnostics on current line", vim.log.levels.INFO)
    end
end, "Copy diagnostic to clipboard")

map("n", "<Leader>S", function() require("spectre").toggle() end, "Toggle spectre")

-- Neotest
map("n", "<Leader>tt", function() require("neotest").run.run() end, "Run nearest test")
map("n", "<Leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, "Run tests in current file")
map("n", "<Leader>tc", function() require("neotest").run.stop() end, "Stop running test(s)")
map("n", "<Leader>ts", function() require("neotest").summary.toggle() end, "View test summary")
map("n", "<Leader>to", function() require("neotest").output.open({ enter = true }) end, "View test output")
