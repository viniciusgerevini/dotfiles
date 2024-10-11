return {
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'EdenEast/nightfox.nvim', -- colorscheme
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    vim.cmd.colorscheme 'nordfox'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
