return {
    {
        "ibhagwan/fzf-lua",
        run = "make",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "junegunn/fzf",
                lazy = true,
                build = "./install --bin",
            },
        },
        config = function()
            require("fzf-lua").setup({
                fzf_bin = "fzf",
                { "fzf-native", "max-perf" },
                fzf_opts = {
                    ["--layout"] = "reverse",
                    ["--border"] = "rounded",
                    ["--no-exact"] = false,
                    ["--tiebreak"] = "length,begin,index",
                    ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
                },
                lsp = {
                    jump1 = true,
                },
                grep_live = {
                    cmd = "rg",
                    rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --sort=path",
                    previewer = "builtin",
                    preview_opts = "--style=numbers,changes --color always --highlight-line {2}",
                    grep_highlights = true,
                    show_matches_only = false,
                    preview_layout = "vertical",
                },
                files = {
                    actions = {
                        ["default"] = function(selected)
                            if #selected == 0 then return end
                            vim.cmd.edit(selected[1])
                            for i = 2, #selected do
                                vim.cmd.badd(selected[i])
                            end
                        end,
                    },
                },
                winopts = {
                    number = true,
                    cursorline = true,
                    cursorcolumn = false,
                    signcolumn = "no",
                    foldenable = false,
                    list = false,
                    height = 0.75,
                    width = 0.80,
                    row = 0.3,
                    col = 0.5,
                    preview = {
                        delay = 250,
                        title = true,
                        scrollbar = "float",
                        layout = "vertical",
                        height = "45%",
                    },
                },
                performance = {
                    max_entries = 10000, -- Max number of entries to process
                    file_scan_limit = 50000, -- Max files to scan in dir
                    path_shorten = 1, -- Min chars displayed for paths
                    LSP_timeout = 10000, -- LSP request timeout (ms)
                },
            })

            vim.cmd("FzfLua register_ui_select")
        end,
    },
}
