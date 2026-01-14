return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
        lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "frappe",
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					rainbow_delimiters = true,
					render_markdown = true,
					which_key = true,
					notify = true,
					barbar = true,
					fzf = true,
					markdown = true,
					mason = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
							ok = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
							ok = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
					mini = {
						enabled = true,
						indentscope_color = "lavender",
					},
				},
			})
            vim.cmd.colorscheme("catppuccin")
		end,
	},
}
