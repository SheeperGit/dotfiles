require("config.settings")
require("config.lazy")

require('nightfox').setup({
	options = { 
		transparent = true,
	},
})

vim.cmd "colorscheme carbonfox"
