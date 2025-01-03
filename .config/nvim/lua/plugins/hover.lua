return {
    {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup {
                init = function()
                    require('hover.providers.lsp')
                end,
                preview_opts = {
                    border = 'single'
                },
                preview_window = false,
                title = true,
            }
        end
    }
}
