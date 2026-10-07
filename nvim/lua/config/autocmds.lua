local group = vim.api.nvim_create_augroup("jordy", { clear = true })

-- Strip trailing whitespace on save, keeping the cursor in place
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  callback = function()
    if vim.bo.binary or vim.bo.filetype == "diff" then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank()
  end,
})
