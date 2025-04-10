return {
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                delay = 100,
                filetypes_allowlist = {},
                filetypes_denylist = {},
            })
        end,
    },
}
