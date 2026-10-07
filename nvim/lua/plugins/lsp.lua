local jdks = vim.fn.expand("~/.asdf/installs/java")

return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig", "saghen/blink.cmp" },
    opts = {
      -- Installed servers are enabled automatically via vim.lsp.enable()
      ensure_installed = { "vtsls", "eslint", "jdtls", "lua_ls" },
    },
    config = function(_, opts)
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Read by nvim-lspconfig's jdtls cmd; Mason's jdtls ships lombok.jar
      vim.env.JDTLS_JVM_ARGS = "-javaagent:" .. vim.fn.stdpath("data") .. "/mason/share/jdtls/lombok.jar"

      vim.lsp.config("jdtls", {
        -- Top-most pom.xml folder (e.g. connect-backend/), not the monorepo's .git root
        root_dir = function(bufnr, on_dir)
          local poms = vim.fs.find("pom.xml", {
            path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
            upward = true,
            limit = math.huge,
          })
          if #poms > 0 then
            on_dir(vim.fs.dirname(poms[#poms]))
          end
        end,
        -- jdtls itself needs Java 21+; asdf's `java` shim has no global version
        cmd_env = { JAVA_HOME = "/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home" },
        settings = {
          java = {
            configuration = {
              runtimes = {
                { name = "JavaSE-17", path = jdks .. "/openjdk-17.0.2" },
                { name = "JavaSE-21", path = jdks .. "/openjdk-21.0.2" },
                { name = "JavaSE-25", path = jdks .. "/corretto-25.0.3.9.1", default = true },
              },
            },
          },
        },
      })

      -- Apply ESLint fixes on save; runs before conform's Prettier format
      local eslint_on_attach = vim.lsp.config.eslint.on_attach
      vim.lsp.config("eslint", {
        on_attach = function(client, bufnr)
          if eslint_on_attach then
            eslint_on_attach(client, bufnr)
          end
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "LspEslintFixAll",
          })
        end,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
          },
        },
      })

      require("mason-lspconfig").setup(opts)
    end,
  },
  {
    -- Only provides server defaults in lsp/*.lua; no setup() call needed
    "neovim/nvim-lspconfig",
    lazy = true,
  },
}
