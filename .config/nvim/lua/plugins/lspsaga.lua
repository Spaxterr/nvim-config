return {
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({
                lightbulb = {
                    enable = false,
                    enable_in_insert = false,
                },
                symbol_in_winbar = {
                    enable = true,
                },
                code_action = {
                    keys = {
                        quit = "<ESC>",
                        exec = "<CR>",
                    },
                },
                definition = {
                    keys = {
                        quit = "<ESC>",
                        toggle_or_open = "<CR>",
                    },
                },
                finder = {
                    keys = {
                        quit = "<ESC>",
                        toggle_or_open = "<CR>",
                    },
                },
            })
        end,
    },
}
