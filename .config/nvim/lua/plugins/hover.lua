return {
    {
        "lewis6991/hover.nvim",
        event = 'LspAttach',
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
