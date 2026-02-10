return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		---@type snacks.Config
		opts = {
			animate = { enabled = false },
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true, hl = "Whitespace" },
			input = {
				enabled = true,
				icon = "",
				icon_hl = "Keyword",
				backdrop = 60,
				border = "rounded",
				title_pos = "left",
				relative = "cursor",
				row = -3,
				col = 0,
				height = 1,
			},
			notifier = { enabled = true },
			scope = { enabled = true },
			quickfile = { enabled = true },
			terminal = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			git = { enabled = true },
		},
	},
}
