return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "saghen/blink.cmp",
      opts = {
        sources = {
          default = { "codecompanion" },
          providers = {
            codecompanion = {
              name = "CodeCompanion",
              module = "codecompanion.providers.completion.blink",
              enabled = true,
            },
          },
        },
      },
    },
  },
  keymaps = {
    toggle = "<C-y>",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "ollama", -- Explicitly set the chat adapter
      },
    },
    log_level = "DEBUG", -- Debug logging is inside `opts`
  },
  keys = {
    { "<leader>lL", "<cmd>CodeCompanionChat<cr>", desc = "Code Companion Chat" },
  },
  config = function(_, opts)
    require("codecompanion").setup(vim.tbl_deep_extend("force", opts, {
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://localhost:11434", -- Local Ollama instance
            },
            headers = {
              ["Content-Type"] = "application/json",
            },
            parameters = {
              sync = true,
              model = "mistral", -- Explicitly pass the model name
            },
          })
        end,
      },
      -- 🚨 Disable Copilot Adapter
      disable_adapters = { "copilot" },
    }))
  end,
}
