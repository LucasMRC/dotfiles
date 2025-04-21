return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			{ "nvim-neotest/nvim-nio", lazy = true },
			{ "rcarriga/nvim-dap-ui", lazy = true },
			{ "theHamsta/nvim-dap-virtual-text", lazy = true },
		},
		config = function()
			local dap = require 'dap'

			require('nvim-dap-virtual-text').setup({})
			local dap_ui = require 'dapui'

			dap_ui.setup({
				controls = {
					enabled = false
				},
				layouts = {
					{
						-- You can change the order of elements in the sidebar
						elements = {
							-- Provide IDs as strings or tables with "id" and "size" keys
							{
								id = "scopes",
								size = 0.75, -- Can be float or integer > 1
							},
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left", -- Can be "left" or "right"
					},
					{
						elements = {
							"repl",
						},
						size = 10,
						position = "bottom", -- Can be "bottom" or "top"
					},
				},
			})

			dap.listeners.before.attach.dap_ui_config = function()
				dap_ui.open()
			end
			dap.listeners.before.launch.dap_ui_config = function()
				dap_ui.open()
			end
			dap.listeners.before.event_terminated.dap_ui_config = function()
				dap_ui.close()
			end
			dap.listeners.before.event_exited.dap_ui_config = function()
				dap_ui.close()
			end

			dap.adapters.chrome = {
				type = "executable",
				command = "node",
				args = { os.getenv("HOME") .. "/.build/vscode-chrome-debug/out/src/chromeDebug.js" }
			}
			dap.configurations.javascript = {
				{
					type = "chrome",
					request = "attach",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					protocol = "inspector",
					port = 9222,
					webRoot = "${workspaceFolder}"
				}
			}

			Keymap("n", "<leader>dc", ":DapContinue<CR>", Desc("D]ebug [C]ontinue"))
			Keymap("n", "<leader>ds", ":DapStepOver<CR>", Desc("D]ebug [S]tep Over"))
			Keymap("n", "<leader>di", ":DapStepInto<CR>", Desc("D]ebug Step [I]nto"))
			Keymap("n", "<leader>do", ":DapStepOut<CR>", Desc("D]ebug Step [O]ut"))
			Keymap("n", "<leader>dS", ":DapStop<CR>", Desc("D]ebug [S]top"))
			Keymap("n", "<leader>dt", ":DapToggleBreakpoint<CR>", Desc("D]ebug [T]oggle Breakpoint"))
			Keymap("n", "<leader>dC", ":lua require'dap'.set_breakpoint(vim.fn.input(('Breakpoint condition: ')))<CR>", Desc("D]ebug [C]onditional"))
			Keymap("n", "<leader>dl", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))", Desc("D]ebug [L]og point"))
			Keymap("n", "<leader>dr", function() dap_ui.open({ reset = true }) end, Desc("D]ebug ui [R]eset"))
			Keymap("n", "<leader>du", dap_ui.toggle, Desc("D]ebug [U]i"))
		end,
	},
	{
		"leoluz/nvim-dap-go",
		keys = {
			{ "<leader>DS", "<cmd>echo 'DAP Started'<CR>", desc = "[D]ap [S]tart", silent = true },
		},
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap",
		},
		config = function()
			local dap_go = require 'dap-go'
			local find_cmd = vim.system({ "find", ".", "-type", "f", "-name", "main.go" }):wait()
			local file_path = find_cmd.stdout:gsub("^%.", ""):gsub("/main.go\n", "")
			local working_dir = vim.fn.getcwd()
			local dap = require 'dap'

			dap_go.setup({
				dap_configurations = {
					{
						type = "go",
						name = "Debug",
						request = "launch",
						logOutput = "dap",
						showLog = true,
						program = working_dir .. file_path,
					},
					{
						type = "go",
						name = "Debug with args",
						request = "launch",
						logOutput = "dap",
						showLog = true,
						args = require("dap-go").get_arguments,
						program = working_dir .. file_path,
					},
				}
			})

			-- Remove default go dap configs
			dap.configurations.go = {
				dap.configurations.go[9],
				dap.configurations.go[8],
			}

			Keymap("n", "<leader>dT", dap_go.debug_test, Desc("D]ebug [T]est"))
		end
	}
}
