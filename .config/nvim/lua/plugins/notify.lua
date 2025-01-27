return {
    { 
        "rcarriga/nvim-notify",
        lazy = false,
        config = function ()
            require('notify').setup({
                stages = "fade",
                timeout = 7000,
                fps = 30,
                render = "wrapped-default",
            })

            vim.notify = require("notify")
        end
    }
}
