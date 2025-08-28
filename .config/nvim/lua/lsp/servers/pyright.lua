return {
    filetypes = { "python" },
    settings = {
        python = {
            analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "strict",
                diagnosticMode = "openFilesOnly",
                stubPath = "typings",
                useLibraryCodeForTypes = true,
                typeshedPaths = {},
                extraPaths = {},
                completeFunctionParens = true,
                indexing = true,
                disableLanguageServices = false,
                disableOrganizeImports = false,
            },
        },
    },
    flags = {
        debounce_text_changes = 200, -- Slightly higher for Python
        allow_incremental_sync = true,
    },
    -- Before init hook for dynamic configuration
    before_init = function(params, config)
        -- Auto-detect Python interpreter
        local python_path = vim.fn.exepath("python3") or vim.fn.exepath("python")
        if python_path ~= "" then
            config.settings.python.defaultInterpreterPath = python_path
        end

        -- Detect virtual environment
        local venv = os.getenv("VIRTUAL_ENV")
        if venv then
            config.settings.python.venvPath = vim.fn.fnamemodify(venv, ":h")
            config.settings.python.venv = vim.fn.fnamemodify(venv, ":t")
        end
    end,
}
