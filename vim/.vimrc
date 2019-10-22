"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug...\n"
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

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
Plug 'vim-scripts/CSApprox' " Make GVim colorschemes work with Vim
Plug 'ntpeters/vim-better-whitespace' " Remove trailing spaces
Plug 'Raimondi/delimitMate' " Autocomplete for quotes, brackets, etc
Plug 'editorconfig/editorconfig-vim' " Editorconfig integration
Plug 'sheerun/vim-polyglot' " Language packs
Plug 'sickill/vim-pasta' " Pasting with indentation context
Plug 'ConradIrwin/vim-bracketed-paste' " set paste mode automatically to avoid indentation issues
Plug 'tpope/vim-surround' " delete, change and insert surroundings
Plug 'terryma/vim-multiple-cursors' " edit multiple selections at same time
Plug 'tyru/open-browser.vim' " Open URLs in the browser
Plug 'viniciusgerevini/tmux-runner' " TMUX integration
Plug 'ryanoasis/vim-devicons' " Filetype icons support (requires patched font)
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " Coc intellisense engine

if v:version >= 704
  "" Snippets
  Plug 'SirVer/ultisnips' " lots of snippets
  Plug 'FelikZ/ctrlp-py-matcher' " faster matcher for ctrlp
endif

Plug 'honza/vim-snippets' " some more snippets

"" Color
Plug 'chriskempson/base16-vim' " Base16 colorscheme

" html / css
Plug 'vim-scripts/HTML-AutoCloseTag' " Autoclose HTML tags
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque' " colorpreview #aaa
Plug 'tpope/vim-haml'
Plug 'othree/html5.vim'

" JavaScript
Plug 'pangloss/vim-javascript' " JavaScript Syntax
Plug 'othree/javascript-libraries-syntax.vim' " Syntax for some JS libraries

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

" faster scroll when syntax on
set lazyredraw

"" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"" Map leader to [space]
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd
set shell=/bin/sh

" enable mouse support
set mouse=a

" splits
set splitbelow
set splitright

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set relativenumber
set conceallevel=1

let no_buffers_menu=1

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

let g:CSApprox_loaded = 1

if $COLORTERM == 'gnome-terminal'
  set term=gnome-256color
else
  if $TERM == 'xterm'
    set term=xterm-256color
  endif
endif

if &term =~ '256color'
  set t_ut=
endif

"" Scroll offset
set scrolloff=10

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" remove line number background
highlight LineNr ctermbg=NONE

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
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

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

" insert current date in ISO8601/W3C format (http://www.w3.org/TR/NOTE-datetime)
noremap <Leader>ct "=strftime('%FT%T%z')<C-M>p

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" Remove spaces on save
autocmd BufEnter * EnableStripWhitespaceOnSave

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" Split
" go to next split
noremap <Leader>sn <C-w><C-w><CR>

"" Search
vnoremap // y/<C-R>"<CR>"

"" Git
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gl :Glog<CR>

" tmux runner
" Prompt and run command
map <Leader>vp :TmuxRunnerPromptCommand<CR>
" Open Vimux prompt with current buffer name
map <Leader>vr :TmuxRunnerPromptCommand bufname("%")<CR>
" Edit last command and rerun
map <Leader>ve :TmuxRunnerEditCommand<CR>
" Run last command executed
map <Leader>vl :TmuxRunnerRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :TmuxRunnerInspect<CR>
" Scroll down pane
map <Leader>vd :TmuxRunnerScrollDown<CR>
" Scroll up pane
map <Leader>vu :TmuxRunnerScrollUp<CR>
" Zoom the tmux runner pane
map <Leader>vz :TmuxRunnerZoom<CR>
" Close pane
map <Leader>vq :TmuxRunnerClose<CR>
" Clear pane
map <Leader>vc :TmuxRunnerClear<CR>
" Stop execution in pane
map <Leader>vx :TmuxRunnerStop<CR>
" Set new pane as runner
map <leader>vs :TmuxRunnerPromptRunner<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" ctrlp.vim
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

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

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
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep          = '▶'
let g:airline_left_alt_sep      = '»'
let g:airline_right_sep         = '◀'
let g:airline_right_alt_sep     = '«'
let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
let g:airline#extensions#readonly#symbol   = '⊘'
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline_symbols.linenr    = '␊'
let g:airline_symbols.branch    = '⎇'
let g:airline_symbols.paste     = 'ρ'
let g:airline_symbols.paste     = 'Þ'
let g:airline_symbols.paste     = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" autocompletion
set completeopt+=preview
set completeopt+=menuone
set completeopt+=noinsert
set shortmess+=c " turn off completion messages

"" NERDTree configuration
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
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

" NERDTree devicons for folders
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:DevIconsEnableFoldersOpenClose = 1

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"*****************************************************************************
"" Language configs
"*****************************************************************************

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab


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
