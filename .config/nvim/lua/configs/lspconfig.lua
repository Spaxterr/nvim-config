-- local languages = require('configs.coc-languages')
-- vim.g.coc_global_extensions = languages

require("nvchad.configs.lspconfig").defaults()
require("mason").setup()

local nvlsp = require("nvchad.configs.lspconfig")

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
    "nginx_language_server",
    "svelte",
}

require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
    automatic_setup = true,
})

local lspconfig = require("lspconfig")
for _, server in ipairs(servers) do
    local status, config = pcall(require, "configs.lsp." .. server) -- Attempt to import from './lsp/{language server name}.lua'
    if not status then -- If the import failed, default to an empty table
        config = {}
    end

    -- Attach NvChad default config options
    config.capabilities = nvlsp.capabilities
    config.on_attach = nvlsp.on_attach
    config.on_init = nvlsp.on_init

    -- Setup language server with config
    lspconfig[server].setup(config)
end
