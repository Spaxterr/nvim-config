return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				transparent_background = not vim.g.neovide,
				float = { transparent = false, solid = false },
				auto_integrations = true,
				lsp_styles = {
					inlay_hints = { background = true },
				},
				integrations = {
					mini = { enabled = true, indentscope_color = "lavender" },
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
