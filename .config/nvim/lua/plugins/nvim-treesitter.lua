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
                rainbow = { enable = true, },
                ensure_installed = { "lua", "vim", "javascript", "typescript", "html", "python", "jsdoc", "css", "java", "markdown", "svelte", "c_sharp", "rust", "yaml" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
}
