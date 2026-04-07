return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        disabled = true,
        branch = "main",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    }
}
