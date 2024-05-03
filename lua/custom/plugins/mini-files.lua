local minifiles_toggle = function(...)
  if not MiniFiles.close() then
    MiniFiles.open(...)
  end
end

return {
  'echasnovski/mini.files',
  version = false,
  keys = { { '\\', minifiles_toggle, { desc = 'Open MiniFiles' } } },
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
