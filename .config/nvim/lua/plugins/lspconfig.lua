return {
	{
		"neovim/nvim-lspconfig",
        event = "VeryLazy",
		config = function()
            require("lspconfig")
            require("lsp.lspconfig")
		end,
	},
}
