local default_notes_path = "~/code/tools/notes/"

-- open or create note
vim.api.nvim_create_user_command(
  'Note',
    function(opts)
      local name = opts.args
      if name == "" then
        local random_name = os.date("%Y%m%d%H%M%S")
        vim.api.nvim_command(':e ' .. default_notes_path .. random_name .. ".md")
      else
        vim.api.nvim_command(':e ' .. default_notes_path .. name)
      end
    end,
    { nargs = "*" }
)

-- open notes folder
vim.api.nvim_create_user_command(
  'Notes',
    function(opts)
        vim.api.nvim_command(':e ' .. default_notes_path)
    end,
  {}
)

vim.api.nvim_create_user_command('Scratch', ":Note scratch.md", {})
