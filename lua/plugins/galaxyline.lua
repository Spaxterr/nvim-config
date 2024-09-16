return {
    {
        "NTBBloodbath/galaxyline.nvim",
        config = function()
            require("galaxyline.themes.eviline")
        end,
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
}
