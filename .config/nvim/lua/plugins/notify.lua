return {
    {
        "rcarriga/nvim-notify",
        event = "VimEnter",
        config = function()
            require("notify").setup({
                stages = "fade",
                timeout = 7000,
                fps = 30,
                render = "compact",
                background_colour = "#303446",
            })

            vim.notify = require("notify")
        end,
    },
}
