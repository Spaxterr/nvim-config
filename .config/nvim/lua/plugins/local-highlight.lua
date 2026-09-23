return {
    {
        'tzachar/local-highlight.nvim',
        event = "LspAttach",
        enabled = false,
        config = function()
            require('local-highlight').setup()
        end
    },
}
