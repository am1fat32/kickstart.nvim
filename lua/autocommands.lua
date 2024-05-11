--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Enter insert mode when opening a new terminal buffer
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Enter insert mode when opening a new terminal buffer',
  group = vim.api.nvim_create_augroup('terminal-init', { clear = true }),
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.api.nvim_feedkeys('i', 'n', true)
    end
  end,
})
