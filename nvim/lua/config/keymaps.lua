local map = vim.keymap.set

map("n", "<Leader>w", "<cmd>write<cr>", { desc = "Save" })
map("n", "<Leader>s", "<cmd>write<cr>", { desc = "Save" })
map("n", "<Leader>q", "<cmd>quit<cr>", { desc = "Quit" })

-- Paragraph jumps, like { and }
map({ "n", "x", "o" }, "<C-j>", "}", { desc = "Next paragraph" })
map({ "n", "x", "o" }, "<C-k>", "{", { desc = "Previous paragraph" })

-- Keep selection after indenting
map("v", ">", ">gv")
map("v", "<", "<gv")

-- No arrow keys
for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
  map({ "n", "v", "o" }, key, "<Nop>")
end

-- Edit / reload config
map("n", "<Leader>ve", "<cmd>edit $MYVIMRC<cr>", { desc = "Edit config" })

-- Picker and explorer mappings live in lua/plugins/snacks.lua,
-- LSP mappings in lua/plugins/lsp.lua.
