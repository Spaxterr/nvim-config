return {
    {
        "dense-analysis/ale",
        event = 'BufEnter',
        config = function()
            local g = vim.g

            g.ale_lint_on_save = 1 -- Lint only on save instead of text changes
            g.ale_lint_on_text_changed = "never" -- Remove real-time linting for performance
            g.ale_lint_on_insert_leave = 0 -- Don't lint when leaving insert mode
            g.ale_cache_executable_check_failures = 1

            g.ale_maximum_file_size = 500000
            g.ale_max_buffer_history_size = 10
            g.ale_max_signs = 100
            g.ale_buffer_sign_delay = 100
            g.ale_history_enabled = 0
            g.ale_parallel_check = 1
            g.ale_lint_delay = 300

            g.ale_set_highlights = 1
            g.ale_set_signs = 1
            g.ale_highlight_problems = 1
            g.ale_use_neovim_diagnostics_api = 1
            g.ale_set_quickfix = 0
            g.ale_set_loclist = 0

            g.ale_linters_explicit = 1
            g.ale_hover_cursor = 1
            g.ale_completion_enabled = 0
            g.ale_fix_on_save = 0
            g.ale_cursor_detail = 0
            g.ale_floating_preview = 0
            g.ale_open_list = 0
            g.ale_virtualtext_cursor = "disabled"
            g.ale_echo_msg_format = "[%linter%] %s (%code%)"
            g.ale_window_msg_format = "[%linter%] %s (%code%)"
            g.ale_disable_lsp = 1

            vim.cmd([[
                highlight ALEError gui=undercurl guisp=#e78284
                highlight ALEWarning gui=undercurl guisp=#e5c890
                highlight ALEInfo gui=undercurl guisp=#81c8be
                highlight ALEStyleError gui=undercurl guisp=#8caaee
                highlight ALEStyleWarning gui=undercurl guisp=#c6d0f5
                highlight SpellBad gui=undercurl guisp=#c6d0f5
            ]])

            -- Python specific
            g.ale_python_flake8_executable = 'python3'
            g.ale_python_flake8_options = "-m flake8 --config ./tox.ini --verbose"

            -- Java specific
            g.ale_java_checkstyle_options = "-c checkstyle.xml"

            -- CSpell specific
            g.ale_cspell_options = "--config ~/cspell.json --show-suggestions"
            g.ale_cspell_use_global_config = 1

            -- g.ale_python_ruff_executable = 'python3'
            -- g.ale_python_ruff_options = '-m ruff check --config ./pyproject.toml'
            -- g.ale_python_ruff_use_config = 1

            g.ale_history_enabled = 1
            g.ale_history_log_output = 1
            g.ale_echo_cursor = 1
            g.ale_keep_list_window_open = 1

            -- Remap highlight groups
            g.ale_type_map = {
                cspell = { W = "I" },
            }

            g.ale_linters = {
                ["*"] = { "cspell" },
                lua = { "lua_language_server", "cspell" },
                javascript = { "eslint", "cspell" },
                typescript = { "eslint", "cspell" },
                typescriptreact = { "eslint", "cspell" },
                python = { "ruff", "cspell" },
                java = { "checkstyle", "cspell" },
                go = { "golangci-lint", "cspell" },
                markdown = { "cspell" },
            }

            g.ale_linter_aliases = {
                svelte = { "typescript", "css", "html" },
            }

            g.ale_pattern_options = {
                [".git/*"] = { ["ale_enabled"] = 0 },
                ["node_modules/*"] = { ["ale_enabled"] = 0 },
                ["*.min.js"] = { ["ale_enabled"] = 0 },
            }
        end,
    },
}
