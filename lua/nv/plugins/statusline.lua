return {
  "nvim-lualine/lualine.nvim",
  event = "BufReadPost",
  opts = {
    theme = "auto",
    icons_enabled = true,
    extensions = { "lazy", "quickfix" },
    options = {
      disabled_filetypes = { "neo-tree", "snacks_dashboard", "Outline" },
    },
    sections = {
      lualine_a = {
        "mode",
      }, -- hide mode
      lualine_b = {
        "branch",
        "diff",
        "diagnostics",
      },
      lualine_c = {
        {
          "filename",
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = true, -- Display new file status (new file means no write after created)
          path = 3, -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
        },
      },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
  config = function(_, opts)
    -- Show info when recording a macro
    local function is_macro_recording()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end
      return "󰑋 " .. reg
    end

    table.insert(opts.sections.lualine_x, 1, {
      is_macro_recording,
      color = { fg = "#333333", bg = "#ff6666" },
      separator = { left = "", right = "" },
      cond = function()
        return is_macro_recording() ~= ""
      end,
    })

    -- Don't display encoding if encoding is UTF-8
    local function encoding()
      local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
      return ret
    end

    table.insert(opts.sections.lualine_x, 1, {
      encoding,
      cond = function()
        return encoding() ~= ""
      end,
    })

    local function getLspName()
      local bufnr = vim.api.nvim_get_current_buf()
      local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
      if next(buf_clients) == nil then
        return "  No servers"
      end
      return buf_clients[1].name
    end

    local function getLinterName()
      local buf_ft = vim.bo.filetype
      local lint_s, lint = pcall(require, "lint")
      if lint_s then
        for ft_k, ft_v in pairs(lint.linters_by_ft) do
          if type(ft_v) == "table" then
            for _, linter in ipairs(ft_v) do
              if buf_ft == ft_k then
                return linter
              end
            end
          elseif type(ft_v) == "string" then
            if buf_ft == ft_k then
              return ft_v
            end
          end
        end
      end
    end

    local function getFormatterName()
      local ok, conform = pcall(require, "conform")
      local formatters = table.concat(conform.list_formatters_for_buffer(), " ")
      if ok then
        for formatter in formatters:gmatch("%w+") do
          if formatter then
            return formatter
          end
        end
      end
    end

    -- Insert Lsp
    table.insert(opts.sections.lualine_x, 1, {
      function()
        return getLspName()
      end,
    })

    -- Insert linter name
    table.insert(opts.sections.lualine_x, 2, {
      function()
        return getLinterName()
      end,
    })

    -- Insert formatter name
    table.insert(opts.sections.lualine_x, 3, {
      function()
        return getFormatterName()
      end,
    })

    -- Don't display fileformat if fileformat is unix
    local function fileformat()
      local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
      return ret
    end

    table.insert(opts.sections.lualine_x, 4, {
      fileformat,
      cond = function()
        return fileformat() ~= ""
      end,
    })

    local function wordCount()
      local wc = vim.fn.wordcount()
      if wc == nil then
        return ""
      end
      if wc["visual_words"] then -- text is selected in visual mode
        return wc["visual_words"] .. " Words/" .. wc["visual_chars"] .. " Chars (Vis)"
      else -- all of the document
        return wc["words"] .. " Words"
      end
    end

    table.insert(opts.sections.lualine_y, 1, {
      wordCount,
      cond = function()
        local ft = vim.bo.filetype
        local count = {
          latex = true,
          tex = true,
          text = true,
          markdown = true,
          vimwiki = true,
        }
        return count[ft] ~= nil
      end,
    })

    require("lualine").setup(opts)
  end,
}
