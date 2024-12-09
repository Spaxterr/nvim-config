return {
    {
        'mfussenegger/nvim-lint',
        config = function ()
            local lint = require('lint')

            lint.linters.trail_space = {
                cmd = 'rgrep',
                args = { '-nH', '\\s$' },
                stdin = false,
                ignore_exitcode = true,
                parser = function(output, bufnr)
                    local diagnostics = {}
                    for line in output:gmatch("[^\r\n]+") do
                        local file, lineno, message = line:match("^(.-):(%d+):(.*)$")
                        if file and lineno then
                            table.insert(diagnostics, {
                                bufnr = bufnr,
                                lnum = tonumber(lineno) - 1,
                                col = 0,
                                severity = vim.diagnostic.severity.INFO,
                                message = "Trailing whitespace",
                                source = "trail_space",
                            })
                        end
                    end
                    return diagnostics
                end,
            }

            lint.linters_by_ft = {
                javascript = {'eslint'},
                typescript = {'eslint'},
                svelte = {'eslint'},
            }
        end
    }
}
