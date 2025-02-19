---@module "lazy"
---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "InsertLeave" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)
    conform.formatters.shfmt = {
      prepend_args = { "-i", "2" }, -- 2 spaces instead of tab
    }
    conform.formatters.stylua = {
      prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
    }
    conform.formatters.yamlfmt = {
      prepend_args = { "-formatter", "indent=2,include_document_start=true,retain_line_breaks_single=true" },
    }
    vim.g.autoformat = vim.g.autoformat
    vim.api.nvim_create_user_command("ToggleAutoformat", function()
      vim.api.nvim_notify("Toggling autoformat", vim.log.levels.INFO, { title = "conform.nvim", timeout = 2000 })
      vim.g.autoformat = vim.g.autoformat == false and true or false
    end, { desc = "Toggling autoformat" })
    vim.keymap.set("n", "<leader>tF", "<cmd>ToggleAutoformat<cr>", { desc = "Toggle format on save" })
  end,

  opts = {
    format_on_save = function()
      -- Disable with a global variable
      if not vim.g.autoformat then
        return
      end
      return { async = true, timeout_ms = 2000, lsp_fallback = false }
    end,

    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Define formatters by filetype.
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier", "markdownlint-cli2" },
      python = { "ruff_fix", "ruff_format" },
      sh = { "shfmt" },
      toml = { "taplo" },
      typescript = { "prettier" },
      yaml = { "yamlfmt" },
    },
    -- Set up format-on-save
    notify_on_error = true,
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" }, -- indent with two spaces
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
