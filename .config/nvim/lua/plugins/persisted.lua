return {
    {
        "olimorris/persisted.nvim",
        lazy = false,
        config = function()
            require("persisted").setup({
                save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
                use_git_branch = true,
                before_save = function()
                    -- Exclude empty buffers from saved sessions
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].modified == false then
                            vim.api.nvim_buf_delete(buf, {})
                        end
                    end
                end,
                ---@return boolean
                should_save = function()
                    -- Do not save alpha dashboard to session
                    if vim.bo.filetype == "alpha" then
                        return false
                    end
                    return true
                end,
                autoload = true,
            })
        end
    }
}
