-- highlight, edit, and navigate code

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':tsupdate',
  opts = {
    ensure_installed = {
      'bash',
      'json',
      'typescript',
      'javascript',
      'tsx',
      'html',
      'css',
      'styled',
      'lua',
      'luadoc',
      'markdown',
      'vim',
      'vimdoc',
    },
    -- autoinstall languages that are not installed
    auto_install = true,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = false,
        node_decremental = '<c-bs>',
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
        goto_next_end = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
        goto_previous_end = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
      },
    },
    highlight = {
      enable = true,
      -- some languages depend on vim's regex highlighting system (such as ruby) for indent rules.
      --  if you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- [[ configure treesitter ]] see `:help nvim-treesitter`

    -- prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
  end,
}
