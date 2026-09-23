return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        config = function()
            require("render-markdown").setup({
                preset = "obsidian",
                restart_highlighter = true, -- Auto-restart highlighter when attached, might be necessary when lazy-loaded
            })
        end
    }
}
