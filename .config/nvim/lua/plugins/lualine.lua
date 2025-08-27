return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            local lsp_progress = require("lsp-progress")
            require("lualine").setup({
                options = {
                    theme = "auto",
                    icons_enabled = true,
                    component_separators = { left = "\u{e0b5}", right = "\u{e0b7}" },
                    section_separators = { left = "\u{e0b4}", right = "\u{E0B6}" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = {
                        "filesize",
                        {
                            function ()
                                return lsp_progress.progress()
                            end
                        }
                    },
                    lualine_y = { "filetype" },
                    lualine_z = { "location" },
                },
                globalstatus = true,
            })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
