return {
    {
        "olimorris/persisted.nvim",
        lazy = false,
        config = function()
            require("persisted").setup({
                save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
                autoload = true,
            })
        end
    }
}
