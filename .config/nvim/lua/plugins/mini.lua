return {
    {
        "echasnovski/mini.nvim",
        event = "InsertEnter",
        config = function()
            require("mini.trailspace").setup({
                only_in_normal_buffers = true,
            })
            require("mini.pairs").setup()
            require("mini.surround").setup()
        end,
    },
}
