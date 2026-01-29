-- Requires wslview (wslu) in WSL
-- sudo ln -s /usr/bin/wslview /usr/local/bin/xdg-open
return {
	"chrishrb/gx.nvim",
	keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Open URI" } },
	cmd = { "Browse" },
	init = function()
		vim.g.netrw_nogx = 1 -- disable netrw gx
	end,
	config = true, -- default settings
	select_prompt = true, -- shows a prompt when multiple handlers match; disable to auto-select the top one
	handlers = {
		plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
		search = true, -- search the web/selection on the web if nothing else is found
	},
}
