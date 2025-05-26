return {
    	'nvim-telescope/telescope.nvim', 
	tag = '0.1.8', 
	dependencies = { 'nvim-lua/plenary.nvim' }, 
	opts = {}, 
	lazy = false,

	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files in cwd" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Fuzzy find recent files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find string in cwd" },
		{ "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Find string under cursor in cwd" },
		{ "<leader>fc", "<cmd>Telescope git commits<cr>", desc = "Find todos" },
	},
}
