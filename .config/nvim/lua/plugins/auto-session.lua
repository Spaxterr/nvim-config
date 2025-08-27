return {
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("auto-session").setup({
				enabled = true,
				auto_save = true,
				auto_restore = true,
				auto_create = true,
				suppressed_dirs = { "~/", "/tmp" },
			})
		end,
	},
}
