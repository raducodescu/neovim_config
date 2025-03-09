return {
  {
    "echasnovski/mini.nvim",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("mini.icons").setup({
        override = require("lspkind").symbol_map, -- Use LSPKind icons
      })
    end,
  },
  {
    "onsails/lspkind.nvim",
    event = "LspAttach", -- Load it when LSP is attached
    config = function()
      require("lspkind").init({
        mode = "symbol_text", -- Show both icon + text
        preset = "codicons", -- Use VSCode-style icons
        symbol_map = {
          Text = "",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "󰊄",
        },
      })
    end,
  },
}
