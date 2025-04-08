return {
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function()
            local lint_progress = function()
                local linters = require("lint").get_running()
                if #linters == 0 then
                    return "󰸞"
                end
                return "󰇘 " .. table.concat(linters, ", ")
            end
            require("lualine").setup({
                options = {
                    theme = "auto",
                    component_separators = { left = "\u{e0b5}", right = "\u{e0b7}" },
                    section_separators = { left = "\u{e0b4}", right = "\u{E0B6}" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", lint_progress, "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = {
                        "filesize",
                        {
                            "lsp_status",
                            icon = "", -- f013
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
