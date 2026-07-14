-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    -- Epic nord theme
    'andersevenrud/nordic.nvim',
    priority = 1000,
    config = function()
      require('nordic').colorscheme {
        underline_option = 'none',
        italic = true,
        custom_colors = function(c, _, cs)
          local constructors = {
            'TSConstructor', -- TS
            '@constructor', -- TS Query
          }
          local functions = {
            -- TS
            'TSFunction',
            'TSFuncMacro',
            'TSMethod',
            -- TS Query
            '@function',
            '@function.macro',
            '@method',
            'Function', -- VL
            'pythonfunction', -- python
            'vimFunction',
            'vimUserFunc', -- vim
          }

          return {
            { constructors, c.bright_cyan, c.none, cs.italic }, -- in C++ variable->constructors() \\ TS docs unclear
            { functions, c.bright_cyan, c.none, cs.italic },
          }
        end,
      }

      if not vim.g.neovide then
        local bg_none_pls = { 'Normal', 'NoText', 'SignColumn', 'GitSignsAdd', 'GitSignsChange', 'GitSignsDelete' }
        for kind in pairs(bg_none_pls) do
          vim.cmd.highlight { kind, 'guibg=None' }
        end
      end
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'nord',
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
    },
  },

  {
    -- Floating terminal
    url = 'https://git.sr.ht/~adigitoleo/haunt.nvim',
    opts = { define_commands = true },
  },
  {
    'Julian/lean.nvim',
    event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',

      'nvim-telescope/telescope.nvim',
    },

    ---@type lean.Config
    opts = {
      mapping = true,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
