-- Built-in defaults since Neovim 0.11: K hover, grn rename, gra code action,
-- grr references, gri implementation, grt type definition, gO symbols,
-- [d / ]d diagnostics, <C-s> signature help (insert mode).
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("jordy_lsp", { clear = true }),
  callback = function(args)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
    end
    map("gd", function() Snacks.picker.lsp_definitions() end, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("grr", function() Snacks.picker.lsp_references() end, "References")
    map("gri", function() Snacks.picker.lsp_implementations() end, "Implementations")
    map("<Leader>e", vim.diagnostic.open_float, "Line diagnostics")
  end,
})
