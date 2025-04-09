return {
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function()
            local winbar = require("lspsaga.symbol.winbar")
            local breadcrumbs = function()
                local text = winbar.get_bar()
                if text then
                    return text
                else
                    return ""
                end
            end
            require("lualine").setup({
                options = {
                    theme = "auto",
                    component_separators = { left = "\u{e0b5}", right = "\u{e0b7}" },
                    section_separators = { left = "\u{e0b4}", right = "\u{E0B6}" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename", breadcrumbs },
                    lualine_x = {
                        "filesize",
                        {
                            "lsp_status",
                            icon = "",
                            symbols = {
                                -- Standard unicode symbols to cycle through for LSP progress:
                                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                                -- Standard unicode symbol for when LSP is done:
                                done = "✓",
                                -- Delimiter inserted between LSP names:
                                separator = " ",
                            },
                        },
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
