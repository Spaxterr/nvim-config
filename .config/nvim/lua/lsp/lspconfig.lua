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

local global_on_init = function(client, _)
    -- Disable semantic tokens for performance
    if client:supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

local global_on_attach = function(client, bufnr)
    require("lsp.keymaps").setup_keymaps(client, bufnr)
end

-- Helper function to compose on_init functions
local function compose_on_init(global_fn, server_fn)
    return function(client, bufnr)
        -- Always run the global on_init first
        if global_fn then
            global_fn(client, bufnr)
        end
        -- Then run the server-specific on_init if it exists
        if server_fn then
            server_fn(client, bufnr)
        end
    end
end

-- Helper function to compose on_attach functions
local function compose_on_attach(global_fn, server_fn)
    return function(client, bufnr)
        -- Always run the global on_attach first
        if global_fn then
            global_fn(client, bufnr)
        end
        -- Then run the server-specific on_attach if it exists
        if server_fn then
            server_fn(client, bufnr)
        end
    end
end

local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' }
}

-- Set global defaults
vim.lsp.config("*", {
    capabilities = capabilities,
    on_init = global_on_init
})

for _, server in ipairs(servers) do
    local status, config = pcall(require, "servers." .. server)
    if not status then
        config = {}
    end

    -- Store the original server-specific functions
    local server_on_init = config.on_init
    local server_on_attach = config.on_attach

    -- Compose the functions - global functions run first, then server-specific
    config.on_init = compose_on_init(global_on_init, server_on_init)
    config.on_attach = compose_on_attach(global_on_attach, server_on_attach)
    config.capabilities = capabilities

    -- Setup language server with composed config
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        -- This will run the global on_attach for any server that attaches
        -- Note: Individual server on_attach functions are already composed above
        global_on_attach(_, args.buf)
    end,
})

return servers
