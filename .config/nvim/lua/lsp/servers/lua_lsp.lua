return {
    on_init = function(client)
        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            workspace = {
                checkThirdParty = false,
            },
        })
    end,
    settings = {
        Lua = {},
    },
}
