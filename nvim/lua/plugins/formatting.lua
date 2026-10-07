local prettier = { "prettier" } -- conform prefers the project's node_modules/.bin/prettier

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        javascript = prettier,
        javascriptreact = prettier,
        typescript = prettier,
        typescriptreact = prettier,
        json = prettier,
        jsonc = prettier,
        css = prettier,
        scss = prettier,
        html = prettier,
        yaml = prettier,
        markdown = prettier,
      },
      -- Only filetypes above format on save. Java is left to `mvn spotless:apply`.
      format_on_save = { timeout_ms = 3000, lsp_format = "never" },
    },
    keys = {
      {
        "<Leader>cf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "x" },
        desc = "Format (uses jdtls for Java)",
      },
    },
  },
}
