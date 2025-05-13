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
            require("mini.cursorword").setup()

            vim.cmd([[
                highlight MiniCursorword guibg=#e5c890
                highlight MiniCursorwordCurrent guibg=#e5c890
            ]])
        end,
    },
}
