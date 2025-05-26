return {
    {
        "echasnovski/mini.nvim",
        lazy = false,
        event = "BufEnter",
        config = function()
            require("mini.trailspace").setup({
                only_in_normal_buffers = true,
            })
            require("mini.pairs").setup()
            require("mini.surround").setup()
        end,
    },
}
