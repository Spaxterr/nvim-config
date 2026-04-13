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
            fuzzy = { use_proximity = false },
            sources = {
                default = { "lsp", "snippets", "path" },
                providers = {
                    lsp = { score_offset = 150 },
                    buffer = { score_offset = -100, min_keyword_length = 5 },
                    path = { score_offset = -50, min_keyword_length = 3 }
                },
            },
            signature = { enabled = true },
            completion = {
                documentation = {
                    auto_show = true,
                    window = { border = "single" },
                },
                menu = {
                    border = "single",
                },
            },
        },
    },
}
