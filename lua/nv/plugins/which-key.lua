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
      { "<leader>T", group = "Tabs" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Window" },
      { "<leader>1", hidden = true },
      { "<leader>2", hidden = true },
      { "<leader>3", hidden = true },
      { "<leader>4", hidden = true },
      { "<leader>5", hidden = true },
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
