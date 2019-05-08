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
Plug 'tomtom/tcomment_vim' " comment/uncomment command with support to embbeded types
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tommcdo/vim-fubitive' " add Bitbucket support to vim-fugitive
Plug 'tommcdo/vim-fugitive-blame-ext' " add commit message to blame on vim-fugitive
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, ... finder for Vim
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline
Plug 'vim-airline/vim-airline-themes' " Airline themes
Plug 'airblade/vim-gitgutter' " Git status indicator
Plug 'vim-scripts/grep.vim' " Grep command integration
Plug 'Raimondi/delimitMate' " Autocomplete for quotes, brackets, etc
Plug 'editorconfig/editorconfig-vim' " Editorconfig integration
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'sickill/vim-pasta' " Pasting with indentation context
Plug 'tpope/vim-surround' " delete, change and insert surroundings
Plug 'terryma/vim-multiple-cursors' " edit multiple selections at same time
Plug 'tyru/open-browser.vim' " Open URLs in the browser
Plug 'viniciusgerevini/vimux' " TMUX integration
Plug 'ryanoasis/vim-devicons' " Filetype icons support (requires patched font)
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'w0rp/ale' " Asyncronous linter

" Snippets
Plug 'SirVer/ultisnips' " lots of snippets
Plug 'honza/vim-snippets' " some more snippets

" Color
Plug 'chriskempson/base16-vim' " Base16 colorscheme

" html / css
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque' " colorpreview #aaa
Plug 'othree/html5.vim'

" JavaScript
Plug 'pangloss/vim-javascript' " JavaScript Syntax
Plug 'othree/javascript-libraries-syntax.vim' " Syntax for some JS libraries
Plug 'mxw/vim-jsx' " JSX syntax

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

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Scroll offset
set scrolloff=10

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

"set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"if exists("*fugitive#statusline")
"  set statusline+=%{fugitive#statusline()}
"endif

" remove line number background
highlight LineNr ctermbg=NONE

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

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Search
" visual mode search
vnoremap // y/<C-R>"<CR>"

" Git
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gl :Glog<CR>

" Run command in TMUX pane
map <Leader>vp :VimuxPromptCommand<CR>
" Open Vimux prompt with current buffer name
map <Leader>vr :VimuxPromptCommand bufname("%")<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>
" close pane
map <Leader>vq :VimuxCloseRunner<CR>
" stop execution in pane
map <Leader>vx :VimuxInterruptRunner<CR>
" set new pane as runner
map <leader>vs :VimuxSetRunner(input('set new runner: '))<CR>

" create pane for vimux instead of using open ones
let g:VimuxUseNearest=0

" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <C-P> :CtrlP<CR>
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

"" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" Ale
highlight ALEErrorSign ctermfg=9
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_linters = {
\   'rust': ['rls', 'cargo']
\}

let g:ale_lint_on_text_changed = 'never'

noremap <Leader>lf :ALEFix<CR>

" use coc for jumps
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" rename current word
nmap <leader>rn <Plug>(coc-rename)

" use <c-j> and <c-k> for selection options
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

"use <tab> for trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" vim-airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
 let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep          = '▶'
let g:airline_right_sep         = '◀'
let g:airline#extensions#readonly#symbol   = '⊘'
let g:airline_symbols.branch    = '⎇'

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

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

noremap YY "+y<CR>

" Buffer nav
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

""*****************************************************************************
""" Language configs
""*****************************************************************************

" javascript
let g:javascript_enable_domhtmlcss = 1

" show leading spaces
hi Conceal guibg=NONE ctermbg=NONE ctermfg=DarkGrey
autocmd BufWinEnter * setl conceallevel=2 concealcursor=nv
autocmd BufWinEnter * syn match LeadingSpace /\(^ *\)\@<= / containedin=ALL conceal cchar=·
autocmd BufReadPre * setl conceallevel=2 concealcursor=nv
autocmd BufReadPre * syn match LeadingSpace /\(^ *\)\@<= / containedin=ALL conceal cchar=·

" show tabs and trailling spaces
set list listchars=tab:→\ ,trail:·
