local toggle_in_default_mode = function(...)
  local minifiles = require 'mini.files'

  if minifiles.close() then
    return
  end

  minifiles.open(...)
end

local toggle_in_cwd = function()
  local minifiles = require 'mini.files'

  if minifiles.close() then
    return
  end

  minifiles.open(vim.api.nvim_buf_get_name(0))
  minifiles.reveal_cwd()
end

return {
  'echasnovski/mini.files',
  version = false,
  keys = {
    { '\\', toggle_in_default_mode, { desc = 'Toggle MiniFiles' } },
    { '<C-\\>', toggle_in_cwd, { desc = 'Toggle MiniFiles (CWD)' } },
  },
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  opts = {
    use_as_default_explorer = true,
  },
  config = function()
    require('mini.files').setup {}
  end,
}
