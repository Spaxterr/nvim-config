return {
    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        event = "LspAttach",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            {
                "echasnovski/mini.snippets",
                version = false,
                config = function()
                    local gen_loader = require("mini.snippets").gen_loader
                    require("mini.snippets").setup({
                        snippets = {
                            gen_loader.from_lang(), -- This includes those defined by friendly-snippets.
                        },
                    })
                end,
            },
            "xzbdmw/cmp-mini-snippets",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                    snippet = {
                        expand = function(args)
                            vim.fn["vsnip#anonymous"](args.body)
                        end,
                    },
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "mini.snippets" },
                    { name = "buffer" },
                    { name = "async_path" },
                    { name = "cmdline" },
                },
                mapping = {
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                },
            })
        end,
    },
}
