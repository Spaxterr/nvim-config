return {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_dir = function(bufnr, on_dir)
        local root_markers = {
            'package-lock.json',
            'yarn.lock',
            'pnpm-lock.yaml',
            'bun.lockb',
            'bun.lock',
            'tsconfig.json',
            'jsconfig.json',
            'package.json',
            '.git'
        }

        local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
        on_dir(project_root)
    end,
    settings = {
        complete_function_calls = true,
        vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
                maxInlayHintLength = 30,
                completion = {
                    enableServerSideFuzzyMatch = true,
                },
            },
        },
        typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
                completeFunctionCalls = true,
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
            },
        },
    },
}
