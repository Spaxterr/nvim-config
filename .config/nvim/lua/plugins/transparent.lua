return {
    {
        "tribela/transparent.nvim",
        lazy = false,
        config = function()
            if not vim.g.neovide then
                require("transparent").setup()
            end
        end
    },
}
