return {
    {
        "lewis6991/hover.nvim",
        event = "VeryLazy",
        config = function()
            require("hover").setup({
                providers = {
                    'hover.providers.diagnostic',
                    'hover.providers.lsp',
                    'hover.providers.dap',
                    'hover.providers.man',
                    'hover.providers.gh',
                    'hover.providers.gh_user',
                },
                title = true,
            })
        end
    }
}
