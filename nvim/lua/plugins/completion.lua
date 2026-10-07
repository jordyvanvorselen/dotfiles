return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship a prebuilt fuzzy matcher
    event = "InsertEnter",
    opts = {
      keymap = { preset = "enter" }, -- <CR> accept, <C-n>/<C-p> select, <C-space> open
      completion = { documentation = { auto_show = true } },
      signature = { enabled = true },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
}
