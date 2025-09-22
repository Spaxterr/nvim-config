return {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    init_options = {
        hostInfo = "neovim",
        maxTsServerMemory = 8192,
        locale = "en",
        globalPlugins = {},
    },
    settings = {
        complete_function_calls = true,
        vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            -- Enhanced experimental features
            experimental = {
                maxInlayHintLength = 30,
                completion = {
                    enableServerSideFuzzyMatch = true,
                    -- Enable auto-imports from node_modules
                    includeCompletionsForModuleExports = true,
                },
            },
        },
        -- Enhanced TypeScript settings
        typescript = {
            -- File operations
            updateImportsOnFileMove = { enabled = "always" },
            includePackageJsonAutoImports = "auto",

            -- Code suggestions and completions
            suggest = {
                completeFunctionCalls = true,
                includeCompletionsForModuleExports = true,
                includeCompletionsWithSnippetText = true,
                autoImports = true,
            },

            -- Enhanced preferences
            preferences = {
                -- Import organization
                includePackageJsonAutoImports = "auto",
                importModuleSpecifier = "shortest",
                importModuleSpecifierEnding = "minimal",
                quoteStyle = "auto",

                -- Code generation preferences
                useAliasesForRenames = true,
                allowTextChangesInNewFiles = true,
                allowRenameOfImportPath = true,
                providePrefixAndSuffixTextForRename = true,

                -- Modern syntax preferences
                includeCompletionsForImportStatements = true,
                includeCompletionsWithClassMemberSnippets = true,
                includeCompletionsWithObjectLiteralMethodSnippets = true,
                includeCompletionsWithInsertText = true,
            },

            -- Enhanced inlay hints
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
                -- Additional inlay hints
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayParameterNameHints = "literals",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            },

            -- Disable formatting, handled by the conform plugin
            format = {
                enable = false,
            },

            -- Survey and telemetry
            surveys = {
                enabled = false,
            },

            -- Workspace symbol search
            workspaceSymbols = {
                search = {
                    includeWorkspaceSymbols = true,
                },
            },

            -- Error reporting and diagnostics
            reportStyleChecksAsWarnings = true,
            validate = { enable = true },

            -- Import sorting and organization
            organizeImports = {
                ignoreCase = "auto",
            },
        },

        -- JavaScript settings (inherits from TypeScript)
        javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
                completeFunctionCalls = true,
                includeCompletionsForModuleExports = true,
                includeCompletionsWithSnippetText = true,
                autoImports = true,
            },
            preferences = {
                importModuleSpecifier = "shortest",
                importModuleSpecifierEnding = "minimal",
                quoteStyle = "auto",
                includePackageJsonAutoImports = "auto",
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
            },
            format = {
                enable = true,
                insertSpaceAfterCommaDelimiter = true,
                insertSpaceAfterSemicolonInForStatements = true,
                insertSpaceBeforeAndAfterBinaryOperators = true,
                insertSpaceAfterKeywordsInControlFlowStatements = true,
                insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
                insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
                semicolons = "ignore",
            },
            validate = { enable = true },
        },

        -- Completion settings
        completions = {
            completeFunctionCalls = true,
        },

        -- Diagnostics settings
        diagnostics = {
            ignoredCodes = {
                -- Add any TypeScript error codes you want to ignore
            },
        },
    },

    -- LSP server capabilities
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                    resolveSupport = {
                        properties = { "documentation", "detail", "additionalTextEdits" },
                    },
                },
            },
        },
    },

    -- Custom handlers for better UX (optional)
    handlers = {
        -- Custom handling for organize imports
        ["_typescript.organizeImports"] = function(_, result, ctx)
            if not result then
                return
            end
            vim.lsp.util.apply_workspace_edit(result, "utf-8")
        end,
    },
}
