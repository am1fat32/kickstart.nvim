-- Autoformat

vim.api.nvim_create_user_command('FormatDisable', function()
  vim.g.disable_autoformat = true
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.g.disable_autoformat = false

  require 'mini.notify'
end, {
  desc = 'Re-enable autoformat-on-save',
})

return {
  'stevearc/conform.nvim',
  lazy = false,
  init = function()
    vim.cmd 'FormatDisable'
  end,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>tf',
      function()
        if vim.g.disable_autoformat then
          vim.cmd 'FormatEnable'
          vim.notify('Format (conform) enabled', vim.log.levels.INFO)

          return
        end

        vim.cmd 'FormatEnable'
        vim.notify('Format (conform) disabled', vim.log.levels.INFO)
      end,
      mode = 'n',
      desc = '[T]oggle [F]ormat enable',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
    },
  },
}
