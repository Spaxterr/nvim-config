return {
    {
        "romgrk/barbar.nvim",
        event = "BufAdd",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        config = function()
            require("barbar").setup({
                animation = false,
                icons = {
                    buffer_index = false,
                    buffer_number = false,
                    button = "",
                    filetype = {
                        custom_colors = false,
                        enabled = true,
                    },
                    separator_at_end = false,
                    modified = { button = "●" },
                },
            })
        end
    },
}
