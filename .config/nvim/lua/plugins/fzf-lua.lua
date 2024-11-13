return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({
                {"fzf-native", "max-perf"},
                grep_live = {
                    cmd = "rg",
                    rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case",
                    previewer = "bat",
                    preview_opts = "--style=numbers,changes --color always --highlight-line {2}",
                    grep_highlights = true,
                    show_matches_only = false,
                    preview_layout = "vertical",
                },
                winopts = {
                    height = 0.75,
                    width = 0.70,
                    row = 0.3,
                    col = 0.5,
                    preview = {
                        delay = 100,
                        title = true,
                        scrollbar = "float",
                        layout = "vertical",
                        height = "45%",
                    }
                },
            })
        end
    }
}
