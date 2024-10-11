-- TMUX integration
return {
  'viniciusgerevini/tmux-runner.vim',
  config = function()
    vim.keymap.set('n', '<Leader>tp', '<cmd>:TmuxRunnerPromptCommand<CR>', { desc = 'TMUX: Prompt and run command' })
    vim.keymap.set('n', '<Leader>tr', '<cmd>:TmuxRunnerPromptCommand bufname(--%")<CR>', { desc = 'TMUX: Open Vimux prompt with current buffer name' })
    vim.keymap.set('n', '<Leader>te', '<cmd>:TmuxRunnerEditCommand<CR>', { desc = 'TMUX: Edit last command and rerun' })
    vim.keymap.set('n', '<Leader>tl', '<cmd>:TmuxRunnerRunLastCommand<CR>', { desc = 'TMUX: Run last command executed' })
    vim.keymap.set('n', '<Leader>ti', '<cmd>:TmuxRunnerInspect<CR>', { desc = 'TMUX: Inspect runner pane' })
    vim.keymap.set('n', '<Leader>td', '<cmd>:TmuxRunnerScrollDown<CR>', { desc = 'TMUX: Scroll down pane' })
    vim.keymap.set('n', '<Leader>tu', '<cmd>:TmuxRunnerScrollUp<CR>', { desc = 'TMUX: Scroll up pane' })
    vim.keymap.set('n', '<Leader>tz', '<cmd>:TmuxRunnerZoom<CR>', { desc = 'TMUX: Zoom the tmux runner pane' })
    vim.keymap.set('n', '<Leader>tq', '<cmd>:TmuxRunnerClose<CR>', { desc = 'TMUX: Close pane' })
    vim.keymap.set('n', '<Leader>tc', '<cmd>:TmuxRunnerClear<CR>', { desc = 'TMUX: Clear pane' })
    vim.keymap.set('n', '<Leader>tx', '<cmd>:TmuxRunnerStop<CR>', { desc = 'TMUX: Stop execution in pane' })
    vim.keymap.set('n', '<leader>ts', '<cmd>:TmuxRunnerPromptRunner<CR>', { desc = 'TMUX: Set new pane as runner' })
  end

}
