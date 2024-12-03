return {
    {
        'nvimtools/none-ls.nvim',
        config = function ()
            local none_ls = require('null-ls')
            local utils = require('null-ls.utils')
            none_ls.setup({
                sources = {
                    -- Custom trailing space detection
                    none_ls.builtins.diagnostics.trail_space.with({
                        command = "rgrep",
                        args = { "-nH", "\\s$" },
                        method = none_ls.methods.DIAGNOSTICS,
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.severity = 4
                            diagnostic.message = "Trailing whitespace"
                        end,
                    }),
                    none_ls.builtins.hover.dictionary,
                },
            })
        end
    }
}
