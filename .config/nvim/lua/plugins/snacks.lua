return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        animate = { enabled = true },
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true, backdrop = 60, border = "rounded", title_pos = "left" },
        notifier = { enabled = true },
        scope = { enabled = true },
        quickfile = { enabled = true },
        terminal = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        scroll = {
            enabled = true,
            animate = {
                duration = {
                    step = 5,
                    total = 100
                },
            }
        },
        git = { enabled = true },
    },
}
