return {
    {
        "echasnovski/mini.nvim",
        version = false,
        lazy = false,
        config = function()
            require("mini.trailspace").setup({
                only_in_normal_buffers = true,
            })
        end,
    },
}
