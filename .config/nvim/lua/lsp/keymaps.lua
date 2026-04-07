local M = {}

local map = vim.keymap.set
local fzf_lua = require("fzf-lua")

function M.setup_keymaps(client, bufnr)
    -- LSP config mappings
    map("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true, buffer = bufnr })
    map("i", "<C-s>", function() require("blink.cmp").show() end,
        { desc = "Show completions", silent = true, buffer = bufnr })
    map({ "n", "x" }, "gd", fzf_lua.lsp_definitions, { silent = true, desc = "Go to definition", buffer = bufnr })
    map("n", "gy", fzf_lua.lsp_typedefs, { silent = true, desc = "Go to type definition", buffer = bufnr })
    map("n", "gi", fzf_lua.lsp_implementations, { silent = true, desc = "Go to implementation", buffer = bufnr })
    map("n", "gr", fzf_lua.lsp_references, { silent = true, desc = "Go to reference(s)", buffer = bufnr })
    map(
        "n",
        "<Leader>di",
        fzf_lua.diagnostics_document,
        { silent = true, desc = "View file diagnostics", buffer = bufnr }
    )
    map(
        "n",
        "<Leader>dw",
        fzf_lua.diagnostics_workspace,
        { silent = true, desc = "View workspace diagnostics", buffer = bufnr }
    )
    map("n", "K", function()
        require('hover').open()
    end, { silent = true, desc = "Show hover doc", buffer = bufnr })
    map("n", "<C-p>", function()
        require('hover').switch('previous')
    end)
    map("n", "<C-n>", function()
        require('hover').switch('next')
    end)
    map(
        { "v", "n", "x" },
        "<leader>cq",
        fzf_lua.lsp_code_actions,
        { silent = true, noremap = true, desc = "Show code actions", buffer = bufnr }
    )
end

return M
