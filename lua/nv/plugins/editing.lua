return {
  {
    "folke/flash.nvim",
    opts = {},
    keys = {
      {
        "ss",
        mode = { "n", "x", "o" },
        -- Jump to any word
        function()
          ---@diagnostic disable: missing-fields
          require("flash").jump({
            pattern = ".", -- initialize pattern with any char
            search = {
              mode = function(pattern)
                -- remove leading dot
                if pattern:sub(1, 1) == "." then
                  pattern = pattern:sub(2)
                end
                -- return word pattern and proper skip pattern
                return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
              end,
            },
          })
        end,
        desc = "Flash",
      },
      -- stylua: ignore start
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
      -- stylua: ignore end
    },
  },

  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Number of lines within which surrounding is searched
      n_lines = 50,
    },
  },

  {
    "gbprod/substitute.nvim",
    keys = {
    -- stylua: ignore start
    { "s", function() require("substitute").operator() end, desc = "Substitute", },
    { "s", mode = "x", function() require("substitute").visual() end, desc = "Substitute", },
      -- stylua: ignore end
    },
    opts = {},
  },

  {
    {
      "folke/todo-comments.nvim",
      event = "BufReadPre", -- needed to highlight keywords
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        highlight = {
          multiline = false, -- I usually only wnat one line to be highlighted
        },
      },
      keys = {
        -- stylua: ignore start
        { "<leader>sT", function() Snacks.picker.todo_comments() end, desc = "Todo", },
        -- stylua: ignore end
      },
    },
  },

  {
    "allaman/emoji.nvim",
    dev = true,
    ft = "markdown",
    opts = {
      enable_cmp_integration = true,
      plugin_path = vim.fn.expand("~/workspace/github.com/allaman"),
    },
  },

  -- emoji blink.cmp integration
  {
    "saghen/blink.cmp",
    dependencies = { "allaman/emoji.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "emoji" },
        providers = {
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
            -- overwrite kind of suggestion
            transform_items = function(ctx, items)
              local kind = require("blink.cmp.types").CompletionItemKind.Text
              for i = 1, #items do
                items[i].kind = kind
              end
              return items
            end,
          },
        },
      },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {},
    keys = {
      -- stylua: ignore start
      { "<leader>R", "", desc = "Search & Replace" },
      { "<leader>RG", "<cmd>GrugFar<cr>", desc = "Open" },
      { "<leader>Rg", "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Open (Limit to current file)"},
      { "<leader>Rw", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<cr>", desc = "Search word under cursor", },
      { "<leader>Rs", mode = "v", "<cmd>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Search selection", },
      -- stylua: ignore end
    },
  },

  {
    "echasnovski/mini.align",
    keys = {
      { "ga", mode = { "v" }, desc = "Align" },
      { "gA", mode = { "v" }, desc = "Align with Preview" },
    },
    opts = {},
  },
}
