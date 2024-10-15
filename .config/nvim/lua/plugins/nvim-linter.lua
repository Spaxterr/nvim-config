return {
    {
        'mfussenegger/nvim-lint',
        config = function()
            local lint = require('lint')

            lint.linters.checkstyle.args = function()
                local config_file = vim.fn.findfile('checkstyle.xml', '.;')
                if config_file ~= '' then
                    return {
                        "-c", config_file,
                        '-f', 'xml',
                    }
                end
            end

            lint.linters_by_ft = {
                javascript = { 'eslint' },
                java = { 'checkstyle' },
                python = { 'flake8' },
                html = { 'tidy' },
            }
        end
    }
}
