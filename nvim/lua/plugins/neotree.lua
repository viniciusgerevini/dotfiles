-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<F2>', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<F3>', ':Neotree reveal=false<CR>', desc = 'NeoTree open', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['<F3>'] = 'close_window',
        },
      },
    },
  },
}
