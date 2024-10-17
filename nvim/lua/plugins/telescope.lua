return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            -- ["<esc>"] = actions.close,
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
      pickers = {
         buffers = {
           sort_mru = true,
           ignore_current_buffer = true,
           theme = "dropdown",
           previewer = false,
         }
       },

      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    -- files
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>e', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fa', function()
      builtin.find_files {
        hidden = true,
      }
    end, { desc = 'Find All files' })

    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Find in Recent Files' })

    -- buffers
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

    -- search
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Grep' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find current Word' })

    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })

    -- misc
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find Resume' })
    -- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    -- vim.keymap.set('n', '<leader>m', builtin.marks, { desc = 'List Marks' })
    -- vim.keymap.set('n', '<leader>P', builtin.registers, { desc = 'Show Registers' })

    -- diagnostics
    vim.keymap.set('n', '<leader>dl', builtin.diagnostics, { desc = 'Diagnostics List' })

    -- git
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git Status' })
    vim.keymap.set('n', '<leader>gc', builtin.git_status, { desc = 'Git Commits' })
    vim.keymap.set('n', '<leader>gbc', builtin.git_status, { desc = 'Git Buffer Commits' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'Find in Open Files' })
  end,
}
