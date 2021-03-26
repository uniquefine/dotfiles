" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

Plug 'chriskempson/base16-vim'

" Better Visual Guide
"Plug 'Yggdroot/indentLine'
" syntax check
Plug 'w0rp/ale'
" Autocomplete
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-racer'
Plug 'Chiel92/vim-autoformat'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ncm2/ncm2-vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Git Plugin
Plug 'tpope/vim-fugitive'
" Nerdtree
Plug 'preservim/nerdtree'



" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
"" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }
"
"" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
"" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
"" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'
" Autobeautify plugin
"Plug 'chiel92/vim-autoformat'
" Colorthemes
Plug 'srcery-colors/srcery-vim'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" tags
Plug 'ludovicchabant/vim-gutentags'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'

" OCaml
"Plug 'ocaml/merlin'

" Colorschemes
Plug 'altercation/solarized'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'icymind/NeoSolarized'

" Initialize plugin system
call plug#end()

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif

" no idea what this line is doing
"filetype plugin indent on

" UI configuration
syntax on
syntax enable

" True Color Support if it's avaiable in terminal
if has("termguicolors")
    set termguicolors
endif
if has("gui_running")
    set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif



colorscheme seoul256

" Required for operations modifying multiple buffers like rename.
set hidden
set mouse=a
set noshowmode
set noshowmatch
set nolazyredraw

" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase

set expandtab
set shiftwidth=4
set softtabstop=4

" Show number of search matches in status line
set shm-=S

" Autoformat on save
"au BufWrite * :Autoformat

" NCM2
augroup NCM2
    autocmd!
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()
    " :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
    " When the <Enter> key is pressed while the popup menu is visible, it only
    " hides the menu. Use this mapping to close the menu and also start a new line.
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    " uncomment this block if you use vimtex for LaTex
    " autocmd Filetype tex call ncm2#register_source({
    "           \ 'name': 'vimtex',
    "           \ 'priority': 8,
    "           \ 'scope': ['tex'],
    "           \ 'mark': 'tex',
    "           \ 'word_pattern': '\w+',
    "           \ 'complete_pattern': g:vimtex#re#ncm2,
    "           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
    "           \ })
augroup END

" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'
let g:airline_theme='raven'

" Gutentags stores all tags here:
let g:gutentags_cache_dir = '~/.tags'
"Nerdtree
" close vim if NT is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Shortcut
map <C-n> :NERDTreeToggle<CR>

map <C-`> :sp +term<CR>

" Open NT when vim starts without a file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NT when vim starts on dir
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Move between windows with Alt key
noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l

" Let splits appear below and to the right
set splitright
set splitbelow

" remap escape key in terminal so its easier to escape
tnoremap <Esc> <C-\><C-n>

