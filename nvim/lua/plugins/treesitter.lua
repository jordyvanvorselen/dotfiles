local parsers = {
  "bash", "css", "diff", "dockerfile", "html", "java", "javascript", "json",
  "lua", "markdown", "markdown_inline", "properties", "regex", "sql", "toml",
  "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("jordy_treesitter", { clear = true }),
        callback = function(args)
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
