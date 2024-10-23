"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug...\n"
  silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'scrooloose/nerdtree' " File tree
Plug 'Xuyuanp/nerdtree-git-plugin' "  Nerdtree Git file status
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " enable colors for filetype
Plug 'numToStr/Comment.nvim' " comment/uncomment commands
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tommcdo/vim-fubitive' " add Bitbucket support to vim-fugitive
Plug 'tommcdo/vim-fugitive-blame-ext' " add commit message to blame on vim-fugitive
Plug 'nvim-lualine/lualine.nvim' " status line
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' } " buffer line
Plug 'airblade/vim-gitgutter' " Git status indicator
Plug 'Raimondi/delimitMate' " Autocomplete for quotes, brackets, etc
Plug 'editorconfig/editorconfig-vim' " Editorconfig integration
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'sickill/vim-pasta' " Pasting with indentation context
Plug 'tpope/vim-surround' " delete, change and insert surroundings
Plug 'mg979/vim-visual-multi' " edit multiple selections at same time
Plug 'tyru/open-browser.vim' " Open URLs in the browser
Plug 'viniciusgerevini/tmux-runner.vim' " TMUX integration
Plug 'ryanoasis/vim-devicons' " Filetype icons support (requires patched font)

Plug 'neovim/nvim-lspconfig' " LSP helper configs
" LSP autocompletion integration
Plug 'hrsh7th/nvim-cmp' " autocompletion engine
Plug 'hrsh7th/cmp-nvim-lsp' " comp/lsp integration
Plug 'hrsh7th/cmp-buffer' " completion buffer words source
Plug 'hrsh7th/cmp-path' " completion path source
Plug 'L3MON4D3/LuaSnip' " snipet manager
Plug 'saadparwaiz1/cmp_luasnip' " snipet manager
Plug 'rafamadriz/friendly-snippets' " snippets collection

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " treesitter parser integration

Plug 'mfussenegger/nvim-dap' " debug adapter protocol client
Plug 'rcarriga/nvim-dap-ui' " UI config for dap
Plug 'mxsdev/nvim-dap-vscode-js' " JS dap adapter
Plug 'theHamsta/nvim-dap-virtual-text' " shows variables def and values as virtual text

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder

" Color
" Plug 'chriskempson/base16-vim' " Base16 colorscheme
Plug 'EdenEast/nightfox.nvim' " colorscheme
Plug 'mhartington/oceanic-next' " colorscheme
Plug 'rakr/vim-one' " colorscheme

" html / css
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque' " colorpreview #aaa
Plug 'othree/html5.vim'

" JavaScript
Plug 'pangloss/vim-javascript' " JavaScript Syntax
Plug 'othree/javascript-libraries-syntax.vim' " Syntax for some JS libraries

Plug 'calviken/vim-gdscript3' " Godot's GDScript syntax highlight
Plug 'viniciusgerevini/clyde.vim' " Clyde Dialogue syntax highlighting

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" faster scroll when syntax on
set lazyredraw

" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Map leader to [space]
let mapleader=' '

"" Searching
set ignorecase
set smartcase

""" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac

" enable mouse support
set mouse=a

" splits
set splitbelow
set splitright

" autocompletion
set completeopt=preview
set completeopt+=menuone
set completeopt+=noinsert
set shortmess+=c " turn off completion messages

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set relativenumber

"" Enable hidden buffers
set hidden

" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif

colorscheme nordfox

"" OCEANIC NEXT
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" colorscheme OceanicNext

"" VIM ONE
" colorscheme one
" set background=light

" Scroll offset
set scrolloff=10

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

""*****************************************************************************
""" Functions
""*****************************************************************************
" insert current date in ISO8601/W3C format (http://www.w3.org/TR/NOTE-datetime)
noremap <Leader>ct "=strftime('%FT%T%z')<C-M>p

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" Remove spaces on save
"autocmd BufEnter * EnableStripWhitespaceOnSave

"" Search
" visual mode search
vnoremap // y/<C-R>"<CR>"

" tmux-runner
" Prompt and run command
map <Leader>tp :TmuxRunnerPromptCommand<CR>
" Open Vimux prompt with current buffer name
map <Leader>tr :TmuxRunnerPromptCommand bufname("%")<CR>
" Edit last command and rerun
map <Leader>te :TmuxRunnerEditCommand<CR>
" Run last command executed
map <Leader>tl :TmuxRunnerRunLastCommand<CR>
" Inspect runner pane
map <Leader>ti :TmuxRunnerInspect<CR>
" Scroll down pane
map <Leader>td :TmuxRunnerScrollDown<CR>
" Scroll up pane
map <Leader>tu :TmuxRunnerScrollUp<CR>
" Zoom the tmux runner pane
map <Leader>tz :TmuxRunnerZoom<CR>
" Close pane
map <Leader>tq :TmuxRunnerClose<CR>
" Clear pane
map <Leader>tc :TmuxRunnerClear<CR>
" Stop execution in pane
map <Leader>tx :TmuxRunnerStop<CR>
" Set new pane as runner
map <leader>ts :TmuxRunnerPromptRunner<CR>


" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- Automatically install missing parsers when entering buffer
  auto_install = true,
}
EOF


" Telescope configuration
nnoremap <leader>e <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fa <cmd>lua require('telescope.builtin').find_files({ hidden = true })<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>m <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>p <cmd>lua require('telescope.builtin').registers()<cr>

" Git
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>gbc <cmd>lua require('telescope.builtin').git_bcommits()<cr>

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
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
   }
}
EOF


""*****************************************************************************
""" LSP config
""*****************************************************************************
lua << EOF
local opts = { noremap=true, silent=true }

-- completion capability
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings. See `:help vim.lsp.*` for documentation on any of the below functions

  -- go to declaration
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- go to definition
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  -- show hover info
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- go to implementation
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
  -- go to type definition
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  -- show references
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  -- method signature help
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- workspace related
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- rename symbol
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- show code actions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- format code
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ft', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- diagnostics
  vim.api.nvim_set_keymap('n', '<leader>de', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', opts)
end

require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

require'lspconfig'.gdscript.setup{
  on_attach = on_attach,
  capabilities = capabilities
}


 -- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true
    }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'buffer', keyword_length = 3 },
  })
})

-- Snippets configuration
require("luasnip.loaders.from_vscode").load()

local ls = require 'luasnip'
ls.config.set_config {
  history = true, -- keep last snippet, so you can jump back if necessary
  updateevents = "TextChanged,TextChangedI", -- update snippets as you type
}

_G.complete_snip = function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end
--
_G.snip_go_back = function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end

_G.snip_select_option = function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end

vim.api.nvim_set_keymap("i", "<c-j>", "<cmd>lua complete_snip()<cr>", {silent = true})
vim.api.nvim_set_keymap("s", "<c-j>", "<cmd>lua complete_snip()<cr>", {silent = true})

vim.api.nvim_set_keymap("i", "<c-k>", "<cmd>lua snip_go_back()<cr>", {silent = true})
vim.api.nvim_set_keymap("s", "<c-k>", "<cmd>lua snip_go_back()<cr>", {silent = true})

vim.api.nvim_set_keymap("i", "<c-l>", "<cmd>lua snip_select_option()<cr>", {silent = true})

EOF

""*****************************************************************************
""" DAP config
""*****************************************************************************
lua << EOF
require("dap-vscode-js").setup({
  debugger_path = os.getenv('HOME') .. "/code/tools/vscode-js-debug",
  adapters = { 'pwa-node', 'node-terminal', 'pwa-extensionHost' },
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    }
  }
end

require("dapui").setup()
require("nvim-dap-virtual-text").setup()
EOF
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F6> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F7> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F8> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>db <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>dc <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
nnoremap <silent> <Leader>du <Cmd>lua require'dapui'.toggle()<CR>

" lualine config
lua << EOF
require('lualine').setup()
EOF

lua << EOF
require("bufferline").setup {
  options = {
    diagnostics = "nvim_lsp",
  },
}
EOF

" comments config
lua << EOF
require('Comment').setup()
EOF


""" NERDTree configuration
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*/coverage
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

noremap YY "+y<CR>

" Buffer nav
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

""*****************************************************************************
""" Language configs
""*****************************************************************************

" javascript
let g:javascript_enable_domhtmlcss = 1

" show tabs and trailling spaces
set list listchars=tab:→\ ,trail:·,space:·
