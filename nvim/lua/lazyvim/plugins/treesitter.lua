return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- PERF: no need to load the plugin, if we only need its queries for mini.ai
					local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					local opts = require("lazy.core.plugin").values(plugin, "opts", false)
					local enabled = false
					if opts.textobjects then
						for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
							if opts.textobjects[mod] and opts.textobjects[mod].enable then
								enabled = true
								break
							end
						end
					end
					if not enabled then
						require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					end
				end,
			},
		},
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
		---@type TSConfig
		opts = {
			highlight = { enable = true },
			indent = { enable = true, disable = { "python", "cpp" } },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"c",
				"vimdoc",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
                "rust",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<nop>",
					node_decremental = "<bs>",
				},
			},
			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"Wansmer/treesj",
		--dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			-- Use default keymaps
			-- (<space>m - toggle, <space>j - join, <space>s - split)
			use_default_keymaps = false,

			-- Node with syntax error will not be formatted
			check_syntax_error = true,

			-- If line after join will be longer than max value,
			-- node will not be formatted
			max_join_length = 120,

			-- hold|start|end:
			-- hold - cursor follows the node/place on which it was called
			-- start - cursor jumps to the first symbol of the node being formatted
			-- end - cursor jumps to the last symbol of the node being formatted
			cursor_behavior = "hold",

			-- Notify about possible problems or not
			notify = true,

			-- Use `dot` for repeat action
			dot_repeat = true,
		},
		config = function(_, opts)
			require("treesj").setup(opts)
		end,
		keys = {
			{
				"<leader>m",
				function()
					require("treesj").toggle()
				end,
			},
		},
	},
}
