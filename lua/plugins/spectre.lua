-- Spectre needs additional tools! Check here: https://github.com/nvim-pack/nvim-spectre

return {
  'nvim-pack/nvim-spectre',
  build = false,
  cmd = 'Spectre',
  opts = { open_cmd = 'noswapfile vnew' },
  keys = {
    {
      '<leader>P',
      mode = { 'n' },
      function()
        require('spectre').toggle()
      end,
      desc = 'S(P)ectre: Toggle',
    },
    {
      '<leader>pw',
      mode = { 'n' },
      function()
        require('spectre').open_visual { select_word = true }
      end,
      desc = 'S(P)ectre: Search current word',
    },
    {
      '<leader>pw',
      mode = { 'v' },
      function()
        require('spectre').open_visual()
      end,
      desc = 'S(P)ectre: Search current word',
    },
    {
      '<leader>pp',
      mode = { 'n' },
      function()
        require('spectre').open_file_search { select_word = true }
      end,
      desc = 'S(P)ectre: Search on current file',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
