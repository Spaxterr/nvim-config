return {
	{
		"seblyng/roslyn.nvim",
		-- Without an explicit trigger this plugin never loads (lazy-setup.lua sets
		-- defaults.lazy = true), so its plugin/roslyn.lua never runs vim.lsp.enable
		-- and the server never starts. Load it when a C#/Razor buffer opens.
		ft = { "cs", "razor" },
		config = function()
			require("roslyn.config").setup({
				args = {
					"--logLevel=Information",
					"--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
				},
				broad_search = true,
			})

			-- Roslyn-specific LSP settings. Merged into the config the plugin ships
			-- in lsp/roslyn.lua; capabilities/keymaps still come from lsp/lspconfig.lua.
			vim.lsp.config("roslyn", {
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						csharp_enable_inlay_hints_for_types = true,
						dotnet_enable_inlay_hints_for_indexer_parameters = true,
						dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
						dotnet_enable_inlay_hints_for_other_parameters = true,
						dotnet_enable_inlay_hints_for_parameters = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
					["csharp|completion"] = {
						dotnet_provide_regex_completions = true,
						dotnet_show_completion_items_from_unimported_namespaces = true,
						dotnet_show_name_completion_suggestions = true,
					},
					["csharp|background_analysis"] = {
						-- Analyze the whole solution so diagnostics aren't limited to open files.
						dotnet_analyzer_diagnostics_scope = "fullSolution",
						dotnet_compiler_diagnostics_scope = "fullSolution",
					},
				},
			})

			vim.api.nvim_create_user_command("RoslynatorAnalyze", function()
				if vim.fn.executable("roslynator") == 0 then
					vim.notify(
						"roslynator CLI not found. Install with:\n  dotnet tool install -g roslynator.dotnet.cli",
						vim.log.levels.ERROR
					)
					return
				end

				vim.notify("Roslynator: analyzing solution...", vim.log.levels.INFO)
				vim.system(
					{ "roslynator", "analyze", "--verbosity", "normal" },
					{ cwd = vim.fn.getcwd(), text = true },
					vim.schedule_wrap(function(obj)
						local lines = vim.split((obj.stdout or "") .. (obj.stderr or ""), "\n")
						local efm = "%f(%l\\,%c): %t%*[^:]: %m"
						vim.fn.setqflist({}, " ", { title = "Roslynator", lines = lines, efm = efm })
						local n = #vim.fn.getqflist()
						if n > 0 then
							vim.cmd("copen")
							vim.notify(("Roslynator: %d diagnostic(s)"):format(n), vim.log.levels.WARN)
						else
							vim.notify("Roslynator: clean", vim.log.levels.INFO)
						end
					end)
				)
			end, { desc = "Run Roslynator analyze over the solution into quickfix" })
		end,
	},
}
