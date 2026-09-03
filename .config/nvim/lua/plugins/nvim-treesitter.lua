return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		branch = "main",
		build = ":TSUpdate",
		config = function()
			-- ponytail: main branch has no setup({ensure_installed=...}); install missing parsers by hand
			local ensureInstalled = {
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"python",
				"jsdoc",
				"css",
				"java",
				"markdown",
				"markdown_inline",
				"svelte",
				"c_sharp",
				"rust",
				"yaml",
				"query",
				"sql",
			}
			local installed = require("nvim-treesitter.config").get_installed()
			local missing = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(installed, parser)
				end)
				:totable()
			if #missing > 0 then
				require("nvim-treesitter").install(missing)
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
