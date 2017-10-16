" Mostly stolen from https://github.com/ElmCast/.vim

" Plugins
call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'elmcast/elm-vim'
Plug 'jszakmeister/vim-togglecursor'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-rails'
Plug 'w0rp/ale'
Plug 'kchmck/vim-coffee-script'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'
Plug 'janko-m/vim-test'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-eunuch'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

" General
let mapleader=" "
let maplocalleader=" "
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set fillchars+=vert:\
set number
set ignorecase
set noswapfile
set completeopt=longest,menuone
set hidden " So that we can easily switch buffers without the bang when there are unsaved changes.

" Solorize
set background=dark
colorscheme solarized

" FZF settings
nnoremap <c-p> :FZF<cr>
nnoremap <leader>b :Buffers<cr>

" Taken from https://github.com/junegunn/fzf.vim/issues/27#issuecomment-185761539
function! s:ag_in(...)
  call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, fzf#wrap()))
endfunction

command! -nargs=+ -complete=dir AgIn call s:ag_in(<f-args>)

" tab navigation like firefox
map <C-X> <ESC>:tabnext<CR>
map <C-Z> <ESC>:tabprevious<CR>

" Copy to system clipboard
vnoremap  <leader>y  "+y

" Airline
let g:airline_left_sep= '░'
let g:airline_right_sep= '░'

" NerdTree
map <LEADER>f :NERDTreeTabsToggle<CR>
let g:NERDTreeWinSize = 24
let g:NERDTreeMinimalUI = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {}
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer']
let g:deoplete#omni#input_patterns = {}

" Elm
let g:polyglot_disabled = ['elm']
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_make_show_warnings = 1
let g:deoplete#omni#functions.elm = ['elm#Complete']
let g:deoplete#omni#input_patterns.elm = '[^ \t]+'
let g:deoplete#sources.elm = ['omni'] + g:deoplete#sources._
let g:elm_setup_keybindings = 0 " Disable because we need some bindings for ale

" Vim Test
let test#strategy = "neovim"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader>ad <Plug>(ale_detail)

" Vim JSX and JavaScript
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1
