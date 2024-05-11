return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
      ['<leader>u'] = { name = 'S[U]rround', _ = 'which_key_ignore' },
      ['<leader>p'] = { name = 'S[P]ectre', _ = 'which_key_ignore' },
      ['<leader>L'] = { name = '[L]azy Git', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = '[L]sp', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]iagnostics', _ = 'which_key_ignore' },
    }
    -- visual mode
    require('which-key').register({
      ['<leader>h'] = { 'Git [H]unk' },
      ['<leader>u'] = { 'S[U]rround' },
      ['<leader>p'] = { 'S[P]ectre' },
    }, { mode = 'v' })
  end,
}
