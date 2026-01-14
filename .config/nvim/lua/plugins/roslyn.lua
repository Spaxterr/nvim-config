return {
	{
		"seblyng/roslyn.nvim",
        config = function ()
            require('roslyn.config').setup({
                broad_search = true,
            })
        end
	},
}
