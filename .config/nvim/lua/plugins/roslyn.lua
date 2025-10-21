return {
	{
		"seblyng/roslyn.nvim",
        lazy = false,
        config = function ()
            require('roslyn.config').setup({
                broad_search = true,
            })
        end
	},
}
