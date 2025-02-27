return {
  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
      -- ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
      check_ts = true, -- use treesitter to check for a pair.
      ts_config = {
        lua = { "string" }, -- it will not add pair on that treesitter node
        javascript = { "template_string" },
        java = false, -- don't check treesitter on java
      },
    },
  },

  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    opts = {
      symbol_folding = {
        -- Depth past which nodes will be folded by default
        autofold_depth = 1,
        auto_unfold = {
          hovered = true,
        },
      },
      guides = {
        enabled = true,
      },
      preview_window = {
        auto_jump = true,
      },
      outline_window = {
        show_cursor_line = true,
        hide_cursor = true,
      },
      outline_items = {
        show_symbol_details = false,
        show_symbol_lineno = true,
      },
    },
    keys = {
      { "<leader>to", "<cmd>Outline<cr>", desc = "Toggle Outline" },
    },
  },
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      { "folke/snacks.nvim" }, -- optional
    },
    keys = {
      { "<leader>lh", "<cmd>GoDoc<cr>", desc = "Go documentation" },
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
    cmd = { "GoDoc" },
    opts = {
      picker = {
        type = "snacks",
      },
      window = {
        type = "vsplit",
      },
    },
  },
  {
    "fredrikaverpil/pydoc.nvim",
    version = "*",
    dependencies = {
      { "folke/snacks.nvim" }, -- optional
    },
    keys = {
      { "<leader>lh", "<cmd>GoDoc<cr>", desc = "Go documentation" },
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
    cmd = { "PyDoc" },
    opts = {
      picker = {
        type = "snacks",
      },
      window = {
        type = "vsplit",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },
}
