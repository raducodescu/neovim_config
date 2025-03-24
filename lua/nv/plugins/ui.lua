return {

  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" }) -- no background for dropbar
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>fy",
        function()
          require("yazi").yazi()
        end,
        desc = "Open the file manager",
      },
      {
        "<leader>fw",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open the file manager in the cwd",
      },
    },
    ---@type YaziConfig
    opts = {
      open_for_directories = false,
      enable_mouse_support = true,
      -- log_level = vim.log.levels.DEBUG,
      ---@diagnostic disable-next-line: missing-fields
      hooks = {
        yazi_closed_successfully = function(chosen_file, config, state)
          if chosen_file == nil and state.last_directory.filename then
            vim.notify("Changing directory to " .. state.last_directory.filename)
            vim.fn.chdir(state.last_directory.filename)
          end
        end,
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      { "rcarriga/nvim-notify" },
    },
    keys = {
      { "<leader>n", "", desc = "Noice" },
      { "<leader>nn", "<cmd>Noice all<cr>", desc = "Open Noice" },
    },
    opts = {
      cmdline = {
        view = "cmdline_popup", -- classic cmdline at the botton
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },

      -- You can add any custom commands below that will be available with `:Noice command`
      ---@type table<string, Noice.NoiceCommand>
      commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    ---@class tokyonight.Config
    opts = {
      transparent = false, -- Enable transparency
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",
        floats = "dark",
      },
      dim_inactive = false, -- dims inactive windows
    },
    config = function()
      require("tokyonight").setup()
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },
  {
    "folke/edgy.nvim",
    enabled = true,
    ---@module 'edgy'
    ---@param opts Edgy.Config
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function(opts)
      vim.opt.termguicolors = true
      require("bufferline").setup({})
    end,
  },
}
