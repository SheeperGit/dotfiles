-- Enable 24-bit colors
vim.opt.termguicolors = true

-- Show line numbers
vim.opt.number = true

-- Enable mouse mode (useful for resizing splits)
vim.opt.mouse = 'a'

-- Highlight the line your cursor is on
vim.opt.cursorline = true

-- Always have at least 8 lines visible when scrolling
vim.opt.scrolloff = 8

-- Tab spacing
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Set vim clipboard to sys clipboard (allows clipboard sharing to and from vim)
vim.api.nvim_set_option("clipboard", "unnamed")

-- Bolded white line number where cursor is present
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg='white', bold=true })

-- Black highlight on cursor line
vim.api.nvim_set_hl(0, 'CursorLine', { bg = "#000000" })

-- Transparent statusline
vim.cmd "hi statusline guibg=NONE"

-- General transparent bg set
--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
