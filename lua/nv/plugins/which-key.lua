return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 0,
    height = 25,
    icons = {
      mappings = true, -- disable icons in keymaps
    },
    sort = { "alphanum" },
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>d", group = "Diagnostic" },
      { "<leader>f", group = "Files" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Code" },
      { "<leader>m", group = "Misc" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Toggles" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Window" },
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
