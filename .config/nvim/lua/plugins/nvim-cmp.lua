return {
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = {
            "L3MON4D3/LuaSnip",
        },
        opts = {
            keymap = {
                preset = "none",
                ["<C-j>"] = { "select_next", "fallback" },
                ["<C-k>"] = { "select_prev", "fallback" },
                ["<C-Space>"] = { "show", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            signature = { enabled = true },
            completion = {
                documentation = {
                    auto_show = true,
                    window = { border = "rounded" },
                },
                menu = {
                    border = "rounded",
                },
            },
        },
    },
}
