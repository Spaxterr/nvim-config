return {
    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "zjp-CN/nvim-cmp-lsp-rs",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                    snippet = {
                        expand = function(args)
                            require'luasnip'.lsp_expand(args.body)
                        end,
                    },
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "cmp_lsp_rs" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
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
