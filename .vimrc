if &compatible
  " Vim defaults to `compatible` when selecting a vimrc with the command-line
  " `-u` argument. Override this.
  set nocompatible
endif
set laststatus=2 

" Syntax highlighting
syntax on
colo gruvbox
set t_Co=256
set bg=dark

call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
Plug 'sainnhe/everforest'
Plug 'dracula/vim'
Plug 'sickill/vim-monokai'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/promptline.vim'

" Git integration
Plug 'jmcantrell/vim-virtualenv'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

" comment plugins
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdcommenter'

" writing plugins
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" syntax plugins
Plug 'vim-python/python-syntax'
Plug 'pangloss/vim-javascript'
Plug 'nvie/vim-flake8'
Plug 'elzr/vim-json'
Plug 'rust-lang/rust.vim'
Plug 'tomlion/vim-solidity'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'davidhalter/jedi-vim'
Plug 'ycm-core/YouCompleteMe' 
Plug 'vim-syntastic/syntastic'

" python REPL
Plug 'sillybun/vim-repl'
Plug 'fisadev/vim-isort'

" file navigation
Plug 'scrooloose/nerdtree' 
Plug 'ryanoasis/vim-devicons' 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


call plug#end()


" etc
set ignorecase
set encoding=utf-8
set showcmd 
let mapleader=","
let g:mapleader=","
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" set tab size
" python dev
set tabstop=4
set shiftwidth=4
filetype plugin indent on
set expandtab " makes tabs spaces
set autoindent " smart indent
set showtabline=0  " always show tablines
set number " line numbers
set backspace=2
nnoremap <C-Left> :tabprevious<CR> 
nnoremap <C-Right> :tabnext<CR> 

" full-stack dev
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" airline config
let g:airline#extensions#tabline#enabled = 1
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

" REPL Config
let g:repl_position = 0 " move repl box to bottom
let g:repl_width = 38
nnoremap <leader>t :REPLToggle<CR>
nnoremap <leader>e :REPLSendSession<CR>
let g:repl_console_name = 'PYREPL'
let g:repl_program = {
            \   'python': 'python3',
            \   }

" python dependencies sort
let g:vim_isort_map = '<C-i>'
let g:vim_isort_python_version = 'python3'

set noshowmode " remove redundancy
