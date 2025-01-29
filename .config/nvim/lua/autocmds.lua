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

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'svelte',
    group = vim.api.nvim_create_augroup('svelte_only_keymaps', { clear = true }),
    callback = function()
        vim.keymap.set('n', '<Leader>cf', '<CMD>CocCommand prettier.formatFile<CR>', { desc = "Format file", silent = true, noremap = true })
    end,
})
