return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-telescope/telescope-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dap.set_log_level("DEBUG")

			dap.adapters.python = {
				type = "executable",
				command = "python",
				args = { "-m", "debugpy.adapter" },
			}
			dap.adapters.cpp = {
				type = "server",
				port = "13000",
				host = "127.0.0.1",
				executable = {
					-- CHANGE THIS to your path!
					command = "/home/rrentea/bin/extension/adapter/codelldb",
					args = { "--port", "13000" },

					-- On windows you may have to uncomment this:
					-- detached = false,
				},
			}

			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

			require("nvim-dap-virtual-text").setup({
				enabled = true, -- enable this plugin (the default)
				enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
				highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
				highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
				show_stop_reason = true, -- show stop reason when stopped for exceptions
				commented = false, -- prefix virtual text with comment string
				-- experimental features:
				virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
				all_frames = true, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = 80, -- position the virtual text at a fixed window column (starting from the first text column) ,
				-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
			})

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open(nil)
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close(nil)
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close(nil)
			end
		end,
		keys = {
			{
				"<leader>dh",
				function()
					require("dap").toggle_breakpoint()
				end,
			},
			{
				"<leader>ds",
				function()
					-- require("neo-tree").close()
					local dap = require("dap")
					dap.configurations.python = {} -- Clearing any current configuration
					dap.configurations.cpp = {} -- Clearing any current configuration
					require("dap.ext.vscode").load_launchjs(
						os.getenv("PWD") .. "/.nvim/launch.json",
						{ cppdbg = { "c", "cpp" } }
					)
					dap.continue()
				end,
			},
			{
				"<leader>dq",
				function()
					require("dap").terminate()
					require("dapui").close()
				end,
			},
            { '<S-k>', function() require("dap").step_out() end },
            { "<S-l>", function() require("dap").step_into() end },
            { '<S-j>', function() require("dap").step_over() end },
            { '<S-h>', function() require("dap").continue() end },
            { '<leader>di', function() require('dapui').eval(nil, { enter = true  }) end},
            { '<leader>d?', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes) end },
            { '<leader>dk', function() require("dap").up() end },
            { '<leader>dj', function() require("dap").down() end },
            { '<leader>dc', function() require("dap").run_to_cursor() end },
            { '<leader>dl', function() require('require("dap").ext.vscode').load_launchjs() end },
            { '<leader>df', ':Telescope dap frames<CR>' },
            { '<leader>db', ':Telescope dap list_breakpoints<CR>' },
            { '<leader>du', function() require('dapui').toggle(nil) end },
		},
		lazy = true,
	},

	{
		"simrat39/rust-tools.nvim",
		config = function()
			local rt = require("rust-tools")

			local extension_path = vim.env.HOME .. "/bin/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

			rt.setup({
				tools = {
					inlay_hints = {
						auto = false,
					},
					hover_actions = {
						auto_focus = true,
					},
				},
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			})
		end,
		lazy = true,
	},
}
