return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        branch = "main",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
        config = function()
            local configs = require("nvim-treesitter")

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
                    "markdown_inline",
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
                indent = { enable = true },
            })

            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            local ensureInstalled = {
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
                "markdown_inline",
                "svelte",
                "c_sharp",
                "rust",
                "yaml",
                "query",
                "sql",
                "vim",
                "vimdoc",

            }
            local alreadyInstalled = require('nvim-treesitter.config').get_installed()
            local parsersToInstall = vim.iter(ensureInstalled)
                :filter(function(parser)
                    return not vim.tbl_contains(alreadyInstalled, parser)
                end)
                :totable()
            require('nvim-treesitter').install(parsersToInstall)
        end,
    },
}
