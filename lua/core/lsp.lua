-- LSP Configuration & Plugins
-- TODO: Move telecope actions to telecope.lua?! Consider previous commits of this file

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    { 'folke/neodev.nvim', opts = {} },
    {
      'nvimdev/lspsaga.nvim',
      config = function()
        require('lspsaga').setup {}
      end,
    },
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        map('<leader>ld', function()
          vim.cmd 'Lspsaga goto_definition'
        end, '[L]sp Goto [D]efinition')

        -- Peek at the definition of the word under your cursor.
        map('<leader>lD', function()
          vim.cmd 'Lspsaga peek_definition'
        end, '[L]sp Peek [D]efinition')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>lt', function()
          vim.cmd 'Lspsaga goto_type_definition'
        end, '[L]sp Goto Type [D]efinition')

        -- Peek at the type of the word under your cursor.
        map('<leader>lT', function()
          vim.cmd 'Lspsaga peek_type_definition'
        end, '[L]sp Peek Type [D]efinition')

        -- Show all the symbols in your current document.
        map('<leader>ls', function()
          vim.cmd 'Lspsaga outline'
        end, '[L]sp Outline [S]ymbols')

        -- Find references for the word under your cursor.
        map('<leader>lf', function()
          vim.cmd 'Lspsaga finder'
        end, '[L]sp [F]inder')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>lr', function()
          vim.cmd 'Lspsaga rename'
        end, '[L]sp [R]ename')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>la', function()
          vim.cmd 'Lspsaga code_action'
        end, '[L]sp Code [A]ction')

        -- Show incoming calls for the function under your cursor.
        map('<leader>li', function()
          vim.cmd 'Lspsaga incoming_calls'
        end, '[L]sp [I]ncoming Calls')

        -- Show outgoing calls for the function under your cursor.
        map('<leader>lo', function()
          vim.cmd 'Lspsaga outgoing_calls'
        end, '[L]sp [O]utgoing Calls')


        -- Go to next diagnostic message.
        map('<leader>d]', function()
          vim.cmd 'Lspsaga diagnostic_jump_next'
        end, '[D]iagnostic next message')

        -- Go to previous diagnostic message.
        map('<leader>d[', function()
          vim.cmd 'Lspsaga diagnostic_jump_prev'
        end, '[D]iagnostic prev message')

        -- Show diagnostics under your cursor.
        map('<leader>dc', function()
          vim.cmd 'Lspsaga show_cursor_diagnostics'
        end, '[D]iagnostic [C]ursor')

        -- Show line diagnostics.
        map('<leader>dl', function()
          vim.cmd 'Lspsaga show_line_diagnostics'
        end, '[D]iagnostic [L]ine')

        -- Show buffer diagnostics.
        map('<leader>db', function()
          vim.cmd 'Lspsaga show_buf_diagnostics'
        end, '[D]iagnostic [B]uffer')


        -- Show workspace diagnostics.
        map('<leader>dw', function()
          vim.cmd 'Lspsaga show_workspace_diagnostics'
        end, '[D]iagnostic [W]orkspace')

        -- Opens a popup that displays documentation about the word under your cursor.
        map('K', function()
          vim.cmd 'Lspsaga hover_doc'
        end, 'Hover Documentation')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(event)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event.buf }
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`tsserver`) will work just fine
      tsserver = {},
      --

      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
