return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                autotag = { enable = true },
                rainbow = { enable = true },
                ensure_installed = {
                    "lua",
                    "vim",
                    "javascript",
                    "typescript",
                    "html",
                    "python",
                    "jsdoc",
                    "css",
                    "java",
                    "markdown",
                    "svelte",
                    "c_sharp",
                    "rust",
                    "yaml",
                    "query",
                    "sql",
                    "vim",
                    "vimdoc",
                },
                sync_install = false,
                auto_install = true,
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                indent = { enable = true },
            })
        end,
    },
}
