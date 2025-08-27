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
        },
        typescript = {
            enable = true,
        },
        diagnostics = {
            enable = true,
            reportStyleChecksAsWarnings = true,
            ignoreEmit = true,
        },
        init_options = {
            hostInfo = "neovim",
            preferences = {
                disableSuggestions = false,
                importModuleSpecifierPreference = "relative",
            },
        },
    },
}
