return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        enabled = false,
        branch = "main",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    }
}
