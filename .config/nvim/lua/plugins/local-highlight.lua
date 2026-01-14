return {
    {
        'tzachar/local-highlight.nvim',
        event = "LspAttach",
        config = function()
            require('local-highlight').setup()
        end
    },
}
