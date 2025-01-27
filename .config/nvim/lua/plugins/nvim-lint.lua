return {
    {
        'mfussenegger/nvim-lint',
        config = function()
            local lint = require('lint')

            local function find_checkstyle_config()
                local cwd = vim.fn.getcwd()
                local checkstyle_file = vim.fn.findfile("checkstyle.xml", cwd .. ";")
                return checkstyle_file ~= "" and checkstyle_file or nil
            end

            lint.linters.checkstyle.args = {
                '-c', find_checkstyle_config,
            }

            lint.linters_by_ft = {
                javascript = { 'eslint' },
                typescript = { 'eslint' },
                svelte = { 'eslint' },
                java = { 'checkstyle' },
            }

        end
    }
}
