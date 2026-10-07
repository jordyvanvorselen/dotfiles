local opt = vim.opt

-- Input
opt.mouse = ""
opt.clipboard = "unnamedplus"

-- Indentation (Java overrides this in after/ftplugin/java.lua, .editorconfig wins per project)
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.expandtab = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- UI
opt.number = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.showmode = false -- lualine shows the mode

-- Files
opt.undofile = true
opt.swapfile = false

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { border = "rounded" },
})
