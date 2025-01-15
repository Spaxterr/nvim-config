return {
    {
        "ibhagwan/fzf-lua",
        run = 'make',
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
                    previewer = "builtin",
                    preview_opts = "--style=numbers,changes --color always --highlight-line {2}",
                    grep_highlights = true,
                    show_matches_only = false,
                    preview_layout = "vertical",
                },
                files = {
                    actions = {
                        ["default"] = function(selected)
                            if not selected then return end

                            vim.fn.setqflist({})

                            for i, file in ipairs(selected) do
                                if i == 1 then
                                    vim.cmd('edit ' .. vim.fn.fnameescape(file))
                                else
                                    vim.cmd('badd ' .. vim.fn.fnameescape(file))
                                    vim.cmd('buffer ' .. vim.fn.fnameescape(file))
                                end
                            end
                        end
                    },
                },
                winopts = {
                    height = 0.75,
                    width = 0.80,
                    row = 0.3,
                    col = 0.5,
                    preview = {
                        delay = 250,
                        title = true,
                        scrollbar = "float",
                        layout = "horizontal",
                        height = "45%",
                    }
                },
            })
        end
    }
}
