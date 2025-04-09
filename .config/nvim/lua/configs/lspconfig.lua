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
}

require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
    automatic_setup = true,
})

local lspconfig = require("lspconfig")
for _, server in ipairs(servers) do
    local status, config = pcall(require, "configs.lsp." .. server)
    if not status then
        config = {}
    end

    config.capabilities = nvlsp.capabilities
    config.on_attach = nvlsp.on_attach
    config.on_init = nvlsp.on_init

    lspconfig[server].setup(config)
end
