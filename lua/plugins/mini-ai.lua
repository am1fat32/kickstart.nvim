return {
  'echasnovski/mini.ai',
  version = false,
  opts = {
    n_lines = 500,
  },
  config = function()
    require('mini.ai').setup {}
  end,
}
