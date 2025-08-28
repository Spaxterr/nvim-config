return {
    filetypes = { "go" },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
                useany = true,
            },
            staticcheck = true,
            completeUnimported = true,
        }
    },
}
