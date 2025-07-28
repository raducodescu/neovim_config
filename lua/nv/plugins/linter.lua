return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
        go = { "golangcilint" },
        python = { "ruff" },
        proto = { "protolint" },
        lua = { "selene" },
        markdown = { "markdownlint-cli2" },
        yaml = { "yamllint" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      lint.linters.golangcilint = {
        cmd = "golangci-lint",
        args = { "run", "--out-format", "json" },
        stdin = false,
        ignore_exitcode = true,
        stream = "stdout",
        parser = function(output)
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or not decoded or not decoded.Issues then
            return {}
          end
          local severities = {
            ["error"] = vim.diagnostic.severity.ERROR,
            ["warning"] = vim.diagnostic.severity.WARN,
            ["info"] = vim.diagnostic.severity.INFO,
          }
          local diagnostics = {}
          for _, issue in ipairs(decoded.Issues) do
            table.insert(diagnostics, {
              lnum = issue.Pos.Line - 1,
              col = issue.Pos.Column - 1,
              end_lnum = issue.Pos.Line - 1,
              end_col = issue.Pos.Column,
              message = issue.Text,
              severity = severities[issue.Severity] or vim.diagnostic.severity.WARN,
              source = "golangci-lint",
            })
          end
          return diagnostics
        end,
      }

      local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
