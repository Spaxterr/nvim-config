return {
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_pending = " ",
						package_installed = " ",
						package_uninstalled = " ",
					},
				},

				max_concurrent_installers = 10,
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
        event = "VimEnter",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = require("lsp.lspconfig")
			})
		end,
	},
}
