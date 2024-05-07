return {
  'rcarriga/nvim-notify',
  opts = {},
  init = function()
    vim.notify = function(msg, level, opts)
      -- Ignore "No information available" messages
      if msg == 'No information available' then
        return
      end

      -- Use "nvim-notify" plugin for default vim.notify
      return require('notify').notify(msg, level, opts)
    end
  end,
}
