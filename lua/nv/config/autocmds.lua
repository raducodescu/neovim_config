local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "highlight on yank",
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- Stop all LSP clients (modern version)
    for _, client in pairs(vim.lsp.get_clients()) do
      client.stop(true)
    end

    -- Dismiss Noice popups/messages (if loaded)
    local ok, noice = pcall(require, "noice")
    if ok then
      noice.cmd("dismiss")
    end
  end,
})

api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "go to last loc when opening a buffer",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "grug-far",
    "help",
    "man",
    "qf",
    "query",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "close certain windows with q",
})
