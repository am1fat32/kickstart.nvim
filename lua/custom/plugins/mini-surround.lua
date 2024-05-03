return {
  'echasnovski/mini.surround',
  version = false,
  config = function()
    require('mini.surround').setup {
      mappings = {
        add = '<leader>ua',
        delete = '<leader>ud', -- Delete surrounding
        find = '<leader>uf', -- Find surrounding (to the right)
        find_left = '<leader>uF', -- Find surrounding (to the left)
        highlight = '<leader>uh', -- Highlight surrounding
        replace = '<leader>ur', -- Replace surrounding
        update_n_lines = '<leader>un', -- Update `n_lines`
      },
    }
  end,
}
