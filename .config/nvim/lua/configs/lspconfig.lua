local nvchad_lsp = require("nvchad.configs.lspconfig")
nvchad_lsp.defaults()

local servers = {
    "pyright",
    "lua_ls",
    "rust_analyzer",
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "jdtls",
    "gopls",
    "omnisharp",
    "svelte",
    "tailwindcss",
}

vim.lsp.enable(servers)

local map = vim.keymap.set
local cmp = require("cmp")
local fzf_lua = require("fzf-lua")
local pretty_hover = require("pretty_hover")

local on_attach = function(client, bufnr)
    nvchad_lsp.on_attach(client, bufnr)

    -- LSP config mappings
    map("n", "<Leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol", silent = true, buffer = bufnr })
    map("i", "<C-s>", cmp.mapping.complete(),
        { desc = "Show completions", silent = true, expr = true, buffer = bufnr })
    map({ "n", "x" }, "gd", fzf_lua.lsp_definitions, { silent = true, desc = "Go to definition", buffer = bufnr })
    map("n", "gy", fzf_lua.lsp_typedefs, { silent = true, desc = "Go to type definition", buffer = bufnr })
    map("n", "gi", fzf_lua.lsp_implementations, { silent = true, desc = "Go to implementation", buffer = bufnr })
    map("n", "gr", fzf_lua.lsp_references, { silent = true, desc = "Go to reference(s)", buffer = bufnr })
    map("n", "<Leader>di", fzf_lua.diagnostics_document,
        { silent = true, desc = "View file diagnostics", buffer = bufnr })
    map("n", "<Leader>dw", fzf_lua.diagnostics_workspace,
        { silent = true, desc = "View workspace diagnostics", buffer = bufnr })
    map('n', 'K', pretty_hover.hover, { silent = true, desc = "Show hover doc", buffer = bufnr })
    map({ "v", "n", "x" }, "<leader>cq", fzf_lua.lsp_code_actions,
        { silent = true, noremap = true, desc = "Show code actions", buffer = bufnr })
end

for _, server in ipairs(servers) do
    local status, config = pcall(require, "configs.lsp." .. server) -- Attempt to import from './lsp/{language server name}.lua'
    if not status then                                              -- If the import failed, default to an empty table
        config = {}
    end

    -- Attach NvChad default config options
    config.capabilities = nvchad_lsp.capabilities
    config.on_attach = on_attach
    config.on_init = nvchad_lsp.on_init

    -- Setup language server with config
    vim.lsp.config(server, config)
end
