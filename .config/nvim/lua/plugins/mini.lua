return {
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.trailspace").setup({
                only_in_normal_buffers = true,
            })
        end,
    },
}
