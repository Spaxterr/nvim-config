return {
	{
		"hrsh7th/nvim-cmp",
		enabled = true,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"saadparwaiz1/cmp_luasnip",
			"lukas-reineke/cmp-under-comparator",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local under_comparator = require("cmp-under-comparator")
			local lspkind = require("lspkind")
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					expandable_indicator = true,
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "…",
						show_labelDetails = true,
						menu = {
							nvim_lsp = "[LSP]",
							luasnip = "[Snip]",
							nvim_lsp_signature_help = "[Sig]",
							path = "[Path]",
							buffer = "[Buf]",
						},
					}),
				},
				experimental = {
					ghost_text = { hl_group = "Comment" },
				},
				sorting = {
					priority_weight = 1.0,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						under_comparator.under,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				sources = {
					{ name = "nvim_lsp", priority = 5 },
					{ name = "luasnip", priority = 4 },
					{ name = "nvim_lsp_signature_help", priority = 3 },
					{ name = "path", priority = 2 },
					{ name = "buffer", priority = 1 },
				},
				mapping = {
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				},
			})

			-- Roslyn (and some other servers) attach *client-side* commands to
			-- completion items (e.g. "roslyn.client.completionComplexEdit"), which
			-- perform the real text insertion. cmp-nvim-lsp blindly forwards the
			-- item's command to the *server* via workspace/executeCommand, where a
			-- client command no-ops — so the completion appears to revert to what
			-- you typed. Run client-registered commands locally on confirm instead.
			cmp.event:on("confirm_done", function(event)
				local entry = event.entry
				if not entry then
					return
				end
				local item = entry:get_completion_item()
				local command = item and item.command
				if not command then
					return
				end
				local client = entry.source and entry.source.source and entry.source.source.client
				if client and client.commands and client.commands[command.command] then
					client.commands[command.command](command, {
						client_id = client.id,
						bufnr = vim.api.nvim_get_current_buf(),
					})
				end
			end)
		end,
	},
}
