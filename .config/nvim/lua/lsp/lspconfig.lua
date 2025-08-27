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

local on_init = function(client, _)
	if client:supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

local on_attach = function(client, bufnr)
	require("lsp.keymaps").setup_keymaps(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })
for _, server in ipairs(servers) do
	local status, config = pcall(require, "servers." .. server) -- Attempt to import from './servers/{language server name}.lua'
	if not status then -- If the import failed, default to an empty table
		config = {}
	end

	config.on_attach = on_attach
	config.on_init = on_init
	config.capabilities = capabilities

	-- Setup language server with config
	vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		on_attach(_, args.buf)
	end,
})

return servers
