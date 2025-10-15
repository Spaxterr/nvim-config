return {
	{
		"nvim-neotest/neotest",
		event = "LspAttach",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",

			-- Test adapters
			"Issafalcon/neotest-dotnet",
			"nvim-neotest/neotest-jest",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-plenary",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-dotnet"),
					require("neotest-jest"),
					require("neotest-go"),
					require("neotest-plenary"),
				},
				summary = {
					auto_open = false,
					follow_cursor = true,
				},
				discovery = {
					enabled = true,
				},
				floating = {
					border = "rounded",
					options = {
					},
				},
				status = {
					virtual_text = true,
					enabled = true,
				},
				output = {
					enabled = true,
					open_on_run = false,
				},
				highlights = {
					passed = "DiagnosticSignOk",
					running = "DiagnosticSignWarn",
					failed = "DiagnosticSignError",
					skipped = "DiagnosticSignHint",
					test = "DiagnosticSignInfo",
				},
				watch = {
					enabled = false,
				},
			})
		end,
	},
}
