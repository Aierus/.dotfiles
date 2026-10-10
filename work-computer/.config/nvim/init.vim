if &compatible
  " Vim defaults to `compatible` when selecting a vimrc with the command-line
  " `-u` argument. Override this.
  set nocompatible
endif
set laststatus=2

call plug#begin(stdpath('data') . '/plugged')

" Themes
Plug 'morhetz/gruvbox'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'sainnhe/everforest'
Plug 'dracula/vim'
Plug 'sickill/vim-monokai'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'junegunn/gv.vim'
Plug 'preservim/tagbar'
" Plug 'github/copilot.vim'

" comment plugins
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdcommenter'

" writing plugins
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'

" nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind.nvim'

" syntax plugins
Plug 'vim-python/python-syntax'
" Plug 'pangloss/vim-javascript'
" Plug 'HerringtonDarkholme/yats'
" Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'fatih/vim-go'
Plug 'nvie/vim-flake8'
Plug 'elzr/vim-json'
Plug 'rust-lang/rust.vim'
Plug 'tomlion/vim-solidity'
Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'davidhalter/jedi-vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'dense-analysis/ale'
Plug 'othree/html5.vim'
Plug 'evanleck/vim-svelte'
" Plug 'uki00a/vim-deno'
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets'
Plug 'prisma/vim-prisma'
"  post install (yarn install | npm install) then load plugin only for editing supported files
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'npm install --frozen-lockfile --production',
"   \ 'for': ['javascript', 'typescript','javascriptreact', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'styled-components/vim-styled-components'

" nvim collaboration
Plug 'jbyuki/instant.nvim'

" file navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" clipboard helper
Plug 'tpope/vim-repeat'

" etc
Plug 'wfxr/minimap.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
" Plug 'ervandew/supertab'

call plug#end()

" highlighting and extras
syntax on
" colo gruvbox
lua require("gruvbox").setup() vim.cmd("colorscheme gruvbox")
set t_Co=256
set bg=dark
let &t_ut=''

" etc
set ignorecase
set ttyfast
set encoding=utf-8
set showmode
set showcmd
set matchpairs+=<:>
set hlsearch
set nolist
set rnu
filetype on
filetype plugin indent on
set path+=**
set mouse=a
set clipboard+=unnamedplus
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let mapleader=","
let g:mapleader=","
let g:instant_username = "aierus"
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" set tab size
set tabstop=4
set shiftwidth=4
set expandtab " makes tabs spaces
set autoindent " smart indent
set showtabline=0  " always show tablines
set number " line numbers
set backspace=2
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
:command FormatJSON %!python -m json.tool
:command RMEmptyLines :g/^$/d
:command RMTrailWs :%s/\s\+$//e
map ttt :term<cr>
map tb :TagbarToggle<cr>

autocmd FileType html            setlocal shiftwidth=2 tabstop=2
autocmd FileType css             setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript      setlocal shiftwidth=2 tabstop=4
autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=4
autocmd FileType typescript      setlocal shiftwidth=2 tabstop=4
autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=4
autocmd FileType python          setlocal shiftwidth=4 tabstop=4
autocmd FileType ocaml           setlocal shiftwidth=2 tabstop=2
autocmd FileType make            setlocal shiftwidth=2 tabstop=2 noexpandtab
autocmd FileType lua             setlocal shiftwidth=2 tabstop=2 noexpandtab

" rust format
let g:rustfmt_autosave = 1

"js highlighting
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

" python highlight all
let g:python_highlight_all = 1

" NERDTree config
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
autocmd BufWinEnter * silent NERDTreeMirror

" promptline config
let g:promptline_preset = {
    \'a' : [ promptline#slices#host({ 'only_if_ssh': 1}) ],
    \'b' : [ promptline#slices#python_virtualenv() ],
    \'c' : [ promptline#slices#cwd({ 'dir_limit': 2}) ],
    \'y' : [ promptline#slices#vcs_branch() ],
    \'warn' : [ promptline#slices#last_exit_code() ]}

" vim devicons config
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" fzf settings
let g:fzf_action = {
    \ 'ctrl-t': 'tab-split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp'} }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let $FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git \) -prune -o -print'

" ycm-global-conf
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Limelight Config
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" ale setting
" let g:ale_disable_lsp = 0
" let g:ale_fixers = {'typescript': ['prettier'], 'typescriptreact': ['prettier'], 'c': ['clang-format']}
" let g:ale_linters = {
"     \   'javascript': ['eslint'],
"     \   'typescript': ['eslint'],
"     \   'javascriptreact': ['eslint'],
"     \   'typescriptreact': ['eslint'],
"     \}

let g:ale_fix_on_save = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:airline#extensions#ale#enabled = 1

" closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.tx,*.jsx,*.tsx'

set noshowmode " remove redundancy

" vimtex 
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" nvim stuff

" TextEdit might fail if hidden is not set.
set hidden
set cmdheight=2

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" " GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" PEGA
" Auto Format with Prettier
" let g:prettier#autoformat = 0 " Disable Autoformat on Save when == 0 "
" command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" " Manually Format with Prettier
" nnoremap gp :silent %!prettier --stdin-filepath %<CR>
"

let g:copilot_filetypes = {
      \ '*': v:false,
    \ 'python': v:true,
    \ 'javascript': v:true,
    \ 'typescript': v:true,
    \ 'typescriptreact': v:true,
    \ 'javascriptreact': v:true,
    \ 'go': v:true,
    \ 'rust': v:true,
    \ 'cpp': v:true,
    \ 'c': v:true,
    \ 'html': v:true,
    \ 'css': v:true,
    \ 'scss': v:true,
    \ 'json': v:true,
    \ 'yaml': v:true,
    \ 'ocaml': v:true,
    \ 'solidity': v:true, 
  \ }

let g:python3_host_prog = '/opt/homebrew/bin/python3'

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|TODO|XXX|DEV|dev|NOOP)/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

autocmd ColorScheme gruvbox 
    \ highlight CopilotSuggestion guifg=#555555 ctermfg=8

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

lua require('lsp')
