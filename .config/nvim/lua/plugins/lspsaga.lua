return {
    {
        "nvimdev/lspsaga.nvim",
        event = 'LspAttach',
        config = function()
            require("lspsaga").setup({
                code_action_prompt = {
                    enable = false,
                }
            })
        end,
    }
}
