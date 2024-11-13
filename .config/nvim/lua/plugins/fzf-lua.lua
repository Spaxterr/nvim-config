return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({
                {"telescope", "fzf-native"},
                grep = {
                    rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --threads 4",
                    multiprocess = true,
                    cmd = "rgrep"
                },
                files = {
                    actions = {
                    }
                },
                winopts = {
                    height = 0.75,
                    width = 0.70,
                    row = 0.3,
                    col = 0.5,
                    preview = {
                        delay = 250,
                    }
                }
            })
        end
    }
}
