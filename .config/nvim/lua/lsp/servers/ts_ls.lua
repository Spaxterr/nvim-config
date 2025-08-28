return {
    settings = {
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "literals",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
            completions = {
                completeFunctionCalls = true,
            },
        },
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "svelte"
        },
        typescript = {
            enable = true,
            suggest = {
                includeCompletionsForModuleExports = true,
                includeAutomaticOptionalChainCompletions = true,
            },
        },
        diagnostics = {
            enable = true,
            reportStyleChecksAsWarnings = true,
            ignoreEmit = true,
        },
        init_options = {
            hostInfo = "neovim",
            preferences = {
                -- Import preferences
                importModuleSpecifier = "relative",
                importModuleSpecifierEnding = "minimal",
                includePackageJsonAutoImports = "auto",

                -- Code generation preferences
                includeCompletionsForModuleExports = true,
                includeCompletionsWithInsertText = true,

                -- Performance optimizations
                disableSuggestions = false,
                allowIncompleteCompletions = true,
                allowRenameOfImportPath = true,

                -- Suggest preferences
                providePrefixAndSuffixTextForRename = true,
                provideRefactorNotApplicableReason = true,
            },
        },
    },
    on_attach = function(client, bufnr)
        -- Enable inlay hints if supported (Neovim 0.10+)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- Disable built-in formatting since prettier is used
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
}
