-- Leader must be set before lazy.nvim loads plugins, so their mappings use it.
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
require("config.lazy")
