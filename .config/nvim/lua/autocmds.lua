print("autocmds loaded")
-- Automatically load last session and close unrelated files
vim.api.nvim_create_autocmd("User", {
    pattern = "PersistedTelescopeLoadPre",
    callback = function(session)
        -- Save the currently loaded session using the global variable
        require("persisted").save({ session = vim.g.persisted_loaded_session })

        -- Delete all of the open buffers
        vim.api.nvim_input("<ESC>:%bd!<CR>")
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

