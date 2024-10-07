-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "eslint", "ts_ls", "pylsp", "djlsp", "jsonls", "omnisharp", "svelte", "bashls", "jdtls"}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.svelte.setup({
    cmd = {
        "svelteserver",
        "--stdio"
    }
})

lspconfig.jdtls.setup {
  cmd = { "/usr/bin/java", "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.level=ALL",
          "-noverify", "-Xmx4G",
          "-jar", "/home/developer/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_1.5.700.v20200207-2156.jar",
          "-configuration", "/home/developer/.local/share/jdtls/config_linux",
          "-data", "/home/developer/.local/share/jdtls/workspace"
    },
    root_dir = lspconfig.util.root_pattern('.git', 'pom.xml', 'build.gradle'),
    settings = {
        java = {
            home = '/usr/bin/java',
        },
    },
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
