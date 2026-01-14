return {
    {
        "echasnovski/mini.nvim",
        event = "LspAttach",
        config = function()
            require("mini.trailspace").setup({
                only_in_normal_buffers = true,
            })
            require("mini.pairs").setup()
            require("mini.surround").setup()
        end,
    },
}
