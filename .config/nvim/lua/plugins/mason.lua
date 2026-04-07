return {
	{
		"mason-org/mason.nvim",
        event = "VeryLazy",
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
                registries = {
                    'github:crashdummyy/mason-registry',
                    'github:mason-org/mason-registry',
                },
				max_concurrent_installers = 10,
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
        event = "VeryLazy",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"pyright",
					"lua_ls",
					"rust_analyzer",
					"vtsls",
					"html",
					"cssls",
					"jsonls",
					"yamlls",
					"gopls",
					"svelte",
					"tailwindcss",
				},
			})
		end,
	},
}
