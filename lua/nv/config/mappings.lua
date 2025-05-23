local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Keep selection while indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- Cancel search highlighting with ESC
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear hlsearch and ESC" })

-- window
map("n", "<leader>ws", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>wc", "<cmd>close<cr>", { desc = "Close" })
map("n", "<leader>wT", "<cmd>wincmd T<cr>", { desc = "Move window to new tab" })
map("n", "<leader>wr", "<cmd>wincmd r<cr>", { desc = "rotate down/right" })
map("n", "<leader>wR", "<cmd>wincmd R<cr>", { desc = "rotate up/left" })
map("n", "<leader>wH", "<cmd>wincmd H<cr>", { desc = "Move left" })
map("n", "<leader>wJ", "<cmd>wincmd J<cr>", { desc = "Move down" })
map("n", "<leader>wK", "<cmd>wincmd K<cr>", { desc = "Move up" })
map("n", "<leader>wL", "<cmd>wincmd L<cr>", { desc = "Move right" })
map("n", "<leader>w=", "<cmd>wincmd =<cr>", { desc = "Equalize size" })
map("n", "<leader>wk", "<cmd>resize +5<cr>", { desc = "Up" })
map("n", "<leader>wj", "<cmd>resize -5<cr>", { desc = "Down" })
map("n", "<leader>wh", "<cmd>vertical resize +3<cr>", { desc = "Left" })
map("n", "<leader>wl", "<cmd>vertical resize -3<cr>", { desc = "Right" })

-- buffers
map("n", "<tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bD", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but the current buffer" })

-- terminal mapping
vim.api.nvim_set_keymap("t", "<C-q>", "<C-\\><C-n><C-w>w", { noremap = true, silent = true })
map("t", "<Esc><Esc>", "<C-\\><C-n>")

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })
-- save file
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
-- open path under cursor
map("n", "<leader>fo", "gf", { desc = "Open path under cursor" })

-- diagnostics
-- stylua: ignore start
map("n", "<leader>dj", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
map("n", "<leader>dk", function() vim.diagnostic.goto_prev() end, { desc = "Prev Diagnostic" })
map("n", "<leader>dc", function() vim.diagnostic.open_float() end, { desc = "Toggle current diagnostic" })
map("n", "<leader>dd", function() vim.diagnostic.setqflist() end, { desc = "Open quickfix" })
-- stylua: ignore end

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end, { desc = "move over a closing element" })

-- tabs
-- map("n", "<leader>Tc", "<cmd>tabclose<cr>", { desc = "Close Tab", silent = true })
map("n", "<leader>Tq", ":bdelete<CR>", { desc = "Close Buffer", noremap = true, silent = true })
map("n", "<leader>Tn", "<cmd>tabnew<cr>", { desc = "Open new tab" })
map("n", "<C-t>", "<cmd>tabnew<cr>", { desc = "Open new tab" })
map("n", "<leader>Tl", ":tabnext<CR>", { desc = "Next tab", noremap = true, silent = true })
map("n", "<leader>Th", ":tabprevious<CR>", { desc = "Previous tab", noremap = true, silent = true })

local function safe_del_keymap(mode, key)
  if vim.fn.maparg(key, mode) ~= "" then
    vim.api.nvim_del_keymap(mode, key)
  end
end

-- Disable default mappings to declutter which-key
safe_del_keymap("n", "gra")
safe_del_keymap("x", "gra") -- vim.lsp.buf...
safe_del_keymap("n", "gri") -- vim.lsp.buf...
safe_del_keymap("n", "grn") -- vim.lsp.buf...
safe_del_keymap("n", "grr") -- vim.lsp.buf...
safe_del_keymap("n", "gO") -- vim.lsp.buf...

safe_del_keymap("n", "]d") -- vim.lsp.buf...
safe_del_keymap("n", "]D") -- vim.lsp.buf...

safe_del_keymap("n", "gx") -- open filepath under cursor
safe_del_keymap("x", "gx") -- open filepath under cursor
