return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		config = function()
			require("neo-tree").setup({
				popup_border_style = "",
				enable_git_status = true,
				enable_diagnostics = true,
				window = {
					position = "float",
                    width = "fit_content",
                    mappings = {
                        ["z"] = "",
                    }
				},
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
					},
					follow_current_file = {
						enabled = true,
						leave_dirs_open = true,
					},
				},
			})
		end,
	},
}
