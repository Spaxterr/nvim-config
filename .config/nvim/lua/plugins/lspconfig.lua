return {
	{
		"neovim/nvim-lspconfig",
        event = "VimEnter",
		config = function()
            require("lspconfig")
            require("lsp.lspconfig")
		end,
	},
}
