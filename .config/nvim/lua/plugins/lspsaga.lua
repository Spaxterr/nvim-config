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
                    enable = false,
                    folder_level = 1,
                    show_file = false,
                }
            })
        end,
    },
}
