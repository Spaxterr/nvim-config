local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Download lazyvim if it does not exist
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazy_path,
	})
end

vim.opt.rtp:prepend(lazy_path)

require("lazy").setup({
	defaults = {
		lazy = true,
		version = "*",
	},
	rocks = {
		enabled = false,
	},
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "catppuccin" }, missing = true },
	checker = { enabled = true, frequency = 86400 },
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			reset = true,
			paths = {},
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"rplugin",
				"spellfile_plugin",
			},
		},
	},
})
