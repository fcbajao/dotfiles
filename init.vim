" Plugins
call plug#begin()
" Theme
Plug 'craftzdog/solarized-osaka.nvim'

" UI
Plug 'vim-airline/vim-airline'
Plug 'jszakmeister/vim-togglecursor'
Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'

" Files and Navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rhubarb'

" Navigation and Text manipulation
Plug 'tpope/vim-repeat'
Plug 'https://codeberg.org/andyg/leap.nvim.git'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'

" Syntax and Languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'w0rp/ale'
Plug 'tpope/vim-projectionist'
Plug 'elmcast/elm-vim'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'posva/vim-vue'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sebdah/vim-delve'              " Go debugging with Delve
Plug 'uarun/vim-protobuf'            " Basic Protocol Buffer support
Plug 'bufbuild/vim-buf'              " Buf build tool integration

" Completion and LSP
Plug 'neovim/nvim-lspconfig'         " LSP configuration
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-omni'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

call plug#end()

" General Settings
let mapleader=" "
let maplocalleader=" "
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set fillchars+=vert:\
set number
set ignorecase
set noswapfile
set completeopt=menu,menuone,noselect
set hidden
set termguicolors
syntax enable

" Theme Configuration
colorscheme solarized-osaka

" Treesitter Configuration
lua << EOF
require'nvim-treesitter'.setup {
  ensure_installed = {
    "ruby",
    "javascript",
    "typescript",
    "go",
    "html",
    "css",
    "vim",
    "lua",
    "json",
    "yaml",
    "markdown",
    "proto"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" FZF settings
nnoremap <c-p> :FZF<cr>
nnoremap <leader>b :Buffers<cr>

" Function for ag search in directory
function! s:ag_in(...)
  call fzf#vim#ag(join(a:000[1:], ' '), {'dir': a:1})
endfunction
command! -nargs=+ -complete=dir AgIn call s:ag_in(<f-args>)

" Clipboard settings
set clipboard+=unnamedplus
vnoremap  <leader>y  "+y

" Airline
let g:airline_left_sep= '░'
let g:airline_right_sep= '░'

" NerdTree
map <LEADER>f :NERDTreeTabsToggle<CR>
let g:NERDTreeWinSize = 24
let g:NERDTreeMinimalUI = 1

" ALE Configuration
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader>ad <Plug>(ale_detail)

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'go': ['goimports', 'gofmt'],
\   'ruby': ['rubocop'],
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\   'markdown': ['vale', 'mardownlint'],
\   'go': ['golint', 'govet', 'staticcheck'],
\   'proto': ['buf-lint'],
\}

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_ruby_rubocop_options = '--server'

" JavaScript and JSX
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

" Go
let g:go_fmt_command = 'goimports'
let g:go_auto_type_info = 1

" Go highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

" Filetype-specific settings
augroup filetypespecific
  autocmd!
  " Go settings
  autocmd FileType go set noexpandtab
  autocmd FileType go set shiftwidth=4
  autocmd FileType go set softtabstop=4
  autocmd FileType go set tabstop=4

  " Protocol Buffer settings
  autocmd FileType proto setlocal tabstop=2
  autocmd FileType proto setlocal softtabstop=2
  autocmd FileType proto setlocal shiftwidth=2
  autocmd FileType proto setlocal expandtab
  autocmd FileType proto setlocal commentstring=//\ %s
augroup END

" Go key mappings
autocmd FileType go nmap <leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <leader>dv <Plug>(go-def-vertical)
autocmd FileType go nmap <leader>dt <Plug>(go-def-tab)
autocmd FileType go nmap <leader>gd <Plug>(go-doc)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
autocmd FileType go nmap <leader>gtf <Plug>(go-test-func)

lua << EOF
-- Recommended default leap bindings (see :help leap-mappings)
vim.keymap.set({'n','x','o'}, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
EOF

" nvim-cmp Configuration
lua << EOF
local cmp = require'cmp'

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'buffer',
        keyword_length = 2,
        option = {
          get_bufnrs = function()
            -- Return all visible buffers
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end
        }
      },
      { name = 'omni' },
      { name = 'path' },
    }
  ),
  completion = {
    keyword_length = 1,
    completeopt = 'menu,menuone,noselect'
  }
})
EOF

lua << EOF
-- Capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Go (gopls)
vim.lsp.config('gopls', {
  cmd = { 'gopls', 'serve' },
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
})
vim.lsp.enable('gopls')

-- Protobuf (bufls)
vim.lsp.config('buf_ls', {
  cmd = { 'bufls', 'serve' },
  filetypes = { 'proto' },
  capabilities = capabilities,
})
vim.lsp.enable('buf_ls')

-- Ruby (ruby-lsp)
vim.lsp.config('ruby_lsp', {
  cmd = { 'ruby-lsp' },
  capabilities = capabilities,
  init_options = {
    enabledFeatures = { 'definition', 'completion' },
    indexing = {
      includedPatterns = {
        'app/**/*.rb', 'ee/app/**/*.rb', 'lib/**/*.rb', 'ee/lib/**/*.rb',
        'spec/support/helpers/**/*.rb', 'ee/spec/support/helpers/**/*.rb'
      }
    },
    formatter = 'none',
  },
})
vim.lsp.enable('ruby_lsp')
EOF

lua << EOF
-- https://dx13.co.uk/articles/2023/04/08/neovim-reveal-in-finder/
vim.api.nvim_create_user_command('Rfinder',
    function()
        local path = vim.api.nvim_buf_get_name(0)
        os.execute('open -R ' .. path)
    end,
    {}
)
EOF

" OLD: Show list when multiple matches
" OLD: nnoremap g<C-]> g<C-]>
" OLD: command! RubyTags !ctags -R --languages=ruby --exclude=.git --exclude=log --exclude=tmp --exclude=vendor --exclude=node_modules --extra=+fq --fields=+iaS --tag-relative=yes
" OLD: command! RubyTags !ripper-tags app/ ee/app lib ee/lib spec/support/helpers ee/spec/support/helpers -R --extra=q --fields=+ln --tag-file=tags

" Replace Ctrl-] with LSP go-to-definition
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>

let g:projectionist_heuristics = {
      \ "Gemfile": {
      \   "ee/app/models/*.rb": {"alternate": "ee/spec/models/{}_spec.rb"},
      \   "ee/spec/models/*_spec.rb": {"alternate": "ee/app/models/{}.rb"},
      \   "ee/app/controllers/*.rb": {"alternate": "ee/spec/controllers/{}_spec.rb"},
      \   "ee/spec/controllers/*_spec.rb": {"alternate": "ee/app/controllers/{}.rb"},
      \   "ee/app/services/*.rb": {"alternate": "ee/spec/services/{}_spec.rb"},
      \   "ee/spec/services/*_spec.rb": {"alternate": "ee/app/services/{}.rb"},
      \   "ee/app/workers/*.rb": {"alternate": "ee/spec/workers/{}_spec.rb"},
      \   "ee/spec/workers/*_spec.rb": {"alternate": "ee/app/workers/{}.rb"},
      \   "ee/lib/*.rb": {"alternate": "ee/spec/lib/{}_spec.rb"},
      \   "ee/spec/lib/*_spec.rb": {"alternate": "ee/lib/{}.rb"},
      \   "app/models/*.rb": {"alternate": "spec/models/{}_spec.rb"},
      \   "spec/models/*_spec.rb": {"alternate": "app/models/{}.rb"},
      \   "app/controllers/*.rb": {"alternate": "spec/controllers/{}_spec.rb"},
      \   "spec/controllers/*_spec.rb": {"alternate": "app/controllers/{}.rb"},
      \   "app/services/*.rb": {"alternate": "spec/services/{}_spec.rb"},
      \   "spec/services/*_spec.rb": {"alternate": "app/services/{}.rb"},
      \   "app/workers/*.rb": {"alternate": "spec/workers/{}_spec.rb"},
      \   "spec/workers/*_spec.rb": {"alternate": "app/workers/{}.rb"},
      \   "lib/*.rb": {"alternate": "spec/lib/{}_spec.rb"},
      \   "spec/lib/*_spec.rb": {"alternate": "lib/{}.rb"}
      \ }}
