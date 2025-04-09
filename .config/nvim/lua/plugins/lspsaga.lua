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
            })
        end,
    },
}
