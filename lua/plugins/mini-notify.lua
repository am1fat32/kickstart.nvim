return {
  'echasnovski/mini.notify',
  version = false,
  config = function()
    require('mini.notify').setup {
      lsp_progress = {
        enable = false,
      },
    }
  end,
  init = function()
    vim.notify = require('mini.notify').make_notify()
  end,
}
