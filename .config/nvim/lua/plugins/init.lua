return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "zjp-CN/nvim-cmp-lsp-rs",
            "ray-x/cmp-sql",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "cmp_lsp_rs" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "supermaven-nvim" },
                    { name = "sql" },
                    { name = "dotenv" },
                },
            })
        end,
    },
}
