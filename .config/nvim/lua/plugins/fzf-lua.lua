return {
    {
        "ibhagwan/fzf-lua",
        run = "make",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("fzf-lua").setup({
                fzf_bin = "fzf",
                { "fzf-native", "max-perf" },
                fzf_opts = {
                    ["--layout"] = "reverse",
                    ["--border"] = "rounded",
                    ["--no-exact"] = false,
                    ["--tiebreak"] = "length,begin,index",
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
                        ["default"] = function(selected) -- Immediately open the selected files instead of adding them to a list
                            if not selected then
                                return
                            end

                            vim.fn.setqflist({})

                            for i, file in ipairs(selected) do
                                if i == 1 then
                                    vim.cmd("edit " .. vim.fn.fnameescape(file))
                                else
                                    vim.cmd("badd " .. vim.fn.fnameescape(file))
                                    vim.cmd("buffer " .. vim.fn.fnameescape(file))
                                end
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
        end,
    },
}
