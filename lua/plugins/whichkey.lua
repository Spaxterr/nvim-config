return {
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
            preset = "modern",
            delay = 100,
      },
      keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
        {
            "q",
            function()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            end,
            desc = "Close which-key with q",
        }
      },
    }
}

