return {
    {
        'mfussenegger/nvim-lint',
        config = function ()
            local lint = require('lint')

            lint.linters_by_ft = {
                javascript = {'eslint'},
                typescript = {'eslint'},
                svelte = {'eslint'},
            }
        end
    }
}
