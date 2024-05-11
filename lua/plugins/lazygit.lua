return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>Lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    { '<leader>LG', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit Current File' },
    { '<leader>Lf', '<cmd>LazyGitFilter<cr>', desc = 'LazyGit Filter' },
    { '<leader>LF', '<cmd>LazyGitFilterCurrentFile<cr>', desc = 'LazyGit Filter Current File' },
  },
}
