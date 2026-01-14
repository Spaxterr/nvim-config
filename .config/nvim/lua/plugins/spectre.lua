return {
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
        event = "VeryLazy",
		config = function()
			require("spectre").setup()
		end,
	},
}
