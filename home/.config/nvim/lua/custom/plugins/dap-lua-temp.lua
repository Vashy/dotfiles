-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	-- DAP (Debug Adapter Protocol) support
	{
		"mfussenegger/nvim-dap",
		enabled = false,
		dependencies = {
			-- UI for nvim-dap
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				opts = {},
				config = function(_, opts)
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup(opts)

					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},
			-- Virtual text for debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "[D]ebug: Toggle [B]reakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "[D]ebug: Set Conditional [B]reakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "[D]ebug: [C]ontinue",
			},
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "[D]ebug: Run to [C]ursor",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "[D]ebug: Step [I]nto",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "[D]ebug: Step [O]ver",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "[D]ebug: Step [O]ut",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "[D]ebug: Open [R]EPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "[D]ebug: Run [L]ast",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "[D]ebug: [T]erminate",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "[D]ebug: Toggle [U]I",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				mode = { "n", "v" },
				desc = "[D]ebug: [E]valuate Expression",
			},
		},
	},
}
