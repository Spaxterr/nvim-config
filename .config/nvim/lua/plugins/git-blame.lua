return {
    {
        "f-person/git-blame.nvim",
        event = "VeryLazy",
        lazy = true,
        opts = {
            enabled = false,
            message_template = " <author>: <summary> (<date>)",
            date_format = "%r",
            virtual_text_column = 1,
            delay = 0,
            highlight_group = 'LineNr'
        },
    }
}

