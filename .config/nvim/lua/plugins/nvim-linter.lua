return {
    {
        'mfussenegger/nvim-lint',
        config = function()
            require('lint').linters_by_ft = {
                javascript = { 'eslint' },
                java = { 'checkstyle' },
                python = { 'flake8' },
                html = { 'tidy' },
            }
        end
    }
}
