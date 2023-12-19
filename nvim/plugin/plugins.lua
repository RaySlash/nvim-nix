-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('nvim-surround').setup()

-- Colorscheme
vim.o.background = "dark"
vim.cmd.colorscheme = "gruvbox"
