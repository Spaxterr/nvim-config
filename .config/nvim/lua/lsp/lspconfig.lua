local servers = {
    "bashls",
    "nginx_language_server",
	"pyright",
	"lua_ls",
	"rust_analyzer",
    "vtsls",
	"html",
	"cssls",
	"jsonls",
	"yamlls",
	"jdtls",
	"gopls",
	"svelte",
	"tailwindcss",
}

local global_on_init = function(client, _)
    if client:supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end

    if client:supports_method("textDocument/documentHighlight") then
        local buf_lines = vim.api.nvim_buf_line_count(0)
        if buf_lines > 5000 then
            client.server_capabilities.documentHighlightProvider = false
        end
    end

    if client:supports_method("workspace/didChangeWorkspaceFolders") then
        client.server_capabilities.workspaceFolders = { supported = false }
    end
end

local function compose_on_init(server_fn)
    return function(client, init_result)
        global_on_init(client, init_result)
        if server_fn then
            server_fn(client, init_result)
        end
    end
end

local capabilities = (function()
    local caps = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    )

    -- Enhanced completion capabilities
    caps.textDocument.completion.completionItem.snippetSupport = true
    caps.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    }

    -- Performance optimizations
    caps.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
    caps.textDocument.colorProvider = { dynamicRegistration = false }
    caps.workspace.didChangeWatchedFiles = { dynamicRegistration = false }

    return caps
end)()

-- Set global defaults
vim.lsp.config("*", {
    capabilities = capabilities,
    on_init = global_on_init,
})

for _, server in ipairs(servers) do
    local status, config = pcall(require, "lsp.servers." .. server)
    if not status then
        config = {}
    end

    config.on_init = compose_on_init(config.on_init)

    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

-- NOTE: roslyn is intentionally NOT in the `servers` list above. roslyn.nvim
-- ships its own lsp/roslyn.lua (with an on_init *list* that detects the
-- .sln/.csproj and initializes the workspace) and calls vim.lsp.enable("roslyn")
-- itself when it loads. Running it through the loop would replace that on_init
-- and break workspace init. It still inherits `capabilities` from the "*" config,
-- and keymaps come from the LspAttach autocmd below.

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        require("lsp.keymaps").setup_keymaps(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
    end,
})

return servers
