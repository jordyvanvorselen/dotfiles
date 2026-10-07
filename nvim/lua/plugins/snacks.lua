return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      picker = { enabled = true },
      explorer = { enabled = true }, -- also replaces netrw for `nvim .`
    },
    keys = {
      { "<C-p>", function() Snacks.picker.git_files({ untracked = true }) end, desc = "Find git files" },
      { "<C-f>", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<Leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<Leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word", mode = { "n", "x" } },
      { "<Leader>fh", function() Snacks.picker.help() end, desc = "Help" },
      { "<Leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<Leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "Symbols in file" },
      { "<Leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Symbols in workspace" },
      { "<Leader><Leader>", function() Snacks.picker.resume() end, desc = "Resume last picker" },
      { "<Leader>ex", function() Snacks.explorer() end, desc = "File explorer" },
    },
  },
}
