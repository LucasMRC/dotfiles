return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require'dap'

			require('nvim-dap-virtual-text').setup()
			local dap_ui = require'dapui'

			dap_ui.setup()

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
				args = {os.getenv("HOME") .. "/.build/vscode-chrome-debug/out/src/chromeDebug.js"}
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

			local function set(mode, key, cmd, desc)
				vim.keymap.set(mode, key, cmd, { desc = desc or ""})
			end
			set("n", "<leader>dc", ":DapContinue<CR>", "[D]ebug [C]ontinue")
			set("n", "<leader>ds", ":DapStepOver<CR>", "[D]ebug [S]tep Over")
			set("n", "<leader>di", ":DapStepInto<CR>", "[D]ebug Step [I]nto")
			set("n", "<leader>do", ":DapStepOut<CR>", "[D]ebug Step [O]ut")
			set("n", "<leader>dt", ":DapToggleBreakpoint<CR>", "[D]ebug [T]oggle Breakpoint")
			set("n", "<leader>dC", ":lua require'dap'.set_breakpoint(vim.fn.input(('Breakpoint condition: ')))<CR>", "[D]ebug [C]onditional")
			set("n", "<leader>dl", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))", "[D]ebug [L]og point")
			set("n", "<leader>dr", function() dap_ui.open({ reset = true }) end, "[D]ebug ui [R]eset")
			set("n", "<leader>du", dap_ui.toggle, "[D]ebug [U]i")
		end,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local dap_go = require'dap-go'
			local find_cmd = vim.system({"find", ".", "-type", "f", "-name", "main.go"}):wait()
			local file_path = find_cmd.stdout:gsub("^%.", ""):gsub("/main.go\n", "")

			dap_go.setup({
				dap_configurations = {
					{
						type = "go",
						name = "Debug",
						request = "launch",
						logOutput = "dap",
						showLog = true,
						program = "${workspaceFolder}" .. file_path,
					},
				}
			})

			local function set(mode, key, cmd, desc)
				vim.keymap.set(mode, key, cmd, { desc = desc or ""})
			end

			set("n", "<leader>dT", dap_go.debug_test, "[D]ebug [T]est")
		end
	}
}
