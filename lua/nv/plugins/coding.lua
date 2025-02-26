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
      },
      guides = {
        enabled = false,
      },
    },
    keys = {
      { "<leader>to", "<cmd>Outline<cr>", desc = "Toggle Outline" },
    },
  },

  {
    "allaman/kustomize.nvim",
    enabled = false,
    dev = true,
    ft = "yaml",
    opts = {
      enable_lua_snip = true,
      kinds = {
        show_filepath = true,
        show_line = true,
      },
      run = {
        deprecations29 = {
          args = { "-t", "1.29", "-c=false", "--helm3=false", "-l=error", "-e", "-f" },
          cmd = "kubent",
        },
        deprecations30 = {
          args = { "-t", "1.30", "-c=false", "--helm3=false", "-l=error", "-e", "-f" },
          cmd = "kubent",
        },
        trivy = {
          args = { "-q", "fs" },
          cmd = "trivy",
        },
      },
    },
    config = function(_, opts)
      require("which-key").add({
        { "<leader>k", group = "Kustomize" },
      })
      require("kustomize").setup(opts)
    end,
  },
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      { "folke/snacks.nvim" }, -- optional
    },
    build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
    cmd = { "GoDoc" },
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    keys = {
      { "<leader>lh", "<cmd>GoDoc<cr>", desc = "Go documentation" },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },
}
