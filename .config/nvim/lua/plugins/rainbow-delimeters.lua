return {
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = 'LspAttach',
        config = function()
            require('rainbow-delimiters.setup').setup()
        end
    }
}
