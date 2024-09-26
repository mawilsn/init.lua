return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
    
keys = {

	{ "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Telescope find files" },
	{ "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc ="Telescope live grep" },
	{ "<leader>fb", "<Cmd>Telescope buffers<CR>", desc ="Telescope buffers" },
	{ "<leader>fh", "<Cmd>Telescope help_tags<CR>",desc ="Telescope help tags" },
    },
}
