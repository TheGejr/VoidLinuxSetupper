filetype off                  " required

call plug#begin('~/.config/nvim/plugged')

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'w0rp/ale'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-scripts/DfrankUtil'
Plug 'vim-scripts/vimprj'
Plug 'vim-scripts/indexer.tar.gz'
Plug 'SirVer/ultisnips'
Plug 'easymotion/vim-easymotion'
Plug 'vim-scripts/a.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'tpope/vim-vividchalk'
Plug 'lokaltog/vim-distinguished'
Plug 'tikhomirov/vim-glsl'

"Plug 'Raimondi/delimitMate'
"Plug 'jiangmiao/auto-pairs'
"Plug 'flazz/vim-colorschemes'
"Plug 'chriskempson/base16-vim'
"Plug 'tpope/vim-fugitive'
"Plug 'matze/vim-move'
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'fatih/vim-go', { 'for': 'go' }
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"Plug 'itchyny/lightline.vim'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-match-highlight'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-pyclang' " c/c++
"Plug 'ncm2/ncm2-tern' " JS
"Plug 'lervag/vimtex' " LaTeX

call plug#end()

" ================ Suggestions ======================
  
" show wild menu (menu of suggestions) when typing commands in command mode
set path+=**
set wildmenu
set showcmd



" ================ File management ==================

" Turn off swap files
set noswapfile
set nobackup
set nowb
" TODO: improve behaviour
" reload files changed outside vim
set autoread
" Triger `autoread` when files changes on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None



" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default"



" ================ Srolling =========================

" Start scrolling when we're 8 lines away from margins
set scrolloff=8"



" ================ Encoding =========================

" set encoding to utf8
if &encoding != 'utf-8'
	set encoding=utf-8              "Necessary to show Unicode glyphs
endif



" ================ Keyboard bindings ================
  
" noremap - no recursive mapping"

" Mapping F2 for Danish Spelling and Shift+F2 for English Spelling
map <F2> :set spell spelllang=da <CR>
map <F14> :set spell spelllang=en <CR>

" Mapping f8 for c++ compiling and Shift+F8 for simple compiling and executing
map <F8> :!make <CR>
map <F20> :!g++ % ;and ./a.out <CR>

" Mapping f9 for LaTeX compiling to PDF, hide compiling output if it returns
" `shell returned 1' an error occured use <shift>+<F9> to show output
map <F9> :!pdflatex main.tex >> /dev/null; rm main.aux main.log <CR>

" Mapping Shift+F9 for LaTeX compiling to PDF, with output
" <F21> == map <S-Fx> is equal to map <Fy> where y = x + 12.<Paste>
map <F21> :!pdflatex main.tex <CR>

" fast scrolling
nnoremap K 10j
nnoremap L 10k
vnoremap K 10j
vnoremap L 10k

" Mapping U to Redo.
noremap U <c-r>
noremap <c-r> <NOP>



" ================ Visualization ====================
  
syntax on
set background=dark
colorscheme hybrid

" enable 256bit colors - also: override gnome-terminal's settings
set t_Co=256"



" ================ Indentation ======================

set tabstop=2 softtabstop=1 expandtab shiftwidth=2
set smarttab
set expandtab
set title
set autoindent
set smartindent



" ================ Searching ========================

" Ignorecase when searching
set ignorecase

" incremental search - Vim starts searching when we start typing
set incsearch

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" toggle search highlighting
nnoremap <F3> :set hlsearch!<CR>"



" ================ Performance ======================

" fix slow scrolling that occurs when using mouse and relative numbers
set lazyredraw

" vim timeout (forgot why I need this or if I do at all)
set ttyfast
set ttimeoutlen=10



" ================ Abbreviations ====================

iab wiht with
iab whit with
iab ture true
iab flase false
iab wieght weight
iab hieght height
iab tihs this
iab mian main

" Common typos
:command WQ wq
:command Wq wq
:command W w
:command Q q


" ================ Misc =============================

" highlight matching braces
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=0

" When the last window will have a status line (2 = always)
set laststatus=2

" disable wrapping of long lines into multiple lines
set nowrap

" history
set history=10000

" on some systems the backspace does not work as expected.
" this fixes the problem
set backspace=indent,eol,start

" to avoid hitting:
" 'press ENTER or type command to continue'
" add 'silent' keyword before the command
 
" open a gnome-terminal with a shortcut
noremap <leader><CR> :silent !gnome-terminal<CR>

"disable preview window
set completeopt-=preview

" Line numbers
set relativenumber


" ================ Plugins ==========================

" ################ Airline ##########################

" vim airline fonts
if !exists('g:airline_symbols')
	let g:airline_symbols= {}
endif"
let g:airline_powerline_fonts = 1



" ################ NERDTree #########################

" shift+i (show hidden files)

" ctrl+n open/closes nerd tree
noremap <C-n> :NERDTreeToggle<CR>

" quit nerd tree on file open
let g:NERDTreeQuitOnOpen = 1

" show nerd tree always on the right instead on the left
let g:NERDTreeWinPos = "right""



" ################ UltiSnips ########################

" make a dir Ultisnips in: '~/.config/nvim/UltiSnips/'
" and put your snippets in there
" eg. cpp.snippets

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsUsePythonVersion = 3



" ################ YouCompleteMe ####################

let g:ycm_show_diagnostics_ui = 0

let g:ycm_key_list_select_completion = ['<C-k>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-l>', '<Up>']
let g:SuperTabDefaulCompletionType = '<C-k>'

" disable annoying ycm confirmation
let g:ycm_confirm_extra_conf = 0

" add path to ycm_extra_conf.py (you could also copy the file in the home folder)
" delete '...98' argument from .ycm_extra_conf.py, otherwise syntastic does
" not work properly
let g:ycm_global_ycm_extra_conf ='/home/gejr/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'



" ################ Ale ##############################
  
" autocompletion
let g:ale_completion_enabled = 1

let g:ale_cpp_clang_executable = 'clang++-5.0'

" linter
let g:ale_linters = {
	\	'cpp': ['clang']
	\}
let g:ale_cpp_clang_options = '-std=c++1z -O0 -Wextra -Wall -Wpedantic -I /usr/include/eigen3'

"let g:ale_cpp_clangtidy_options = '-checks="cppcoreguidelines-*"'
"let g:ale_cpp_cpplint_options = ''
"let g:ale_cpp_gcc_options = ''
"let g:ale_cpp_clangcheck_options = ''
"let g:ale_cpp_cppcheck_options = ''



" ################ Clang format #####################

" Clang format - auto formatting
let g:clang_format#command = 'clang-format-3.8'
let g:clang_format#style_options = {
	\ "BreakBeforeBraces" : "Attach",
  \ "UseTab" : "Never",
  \ "IndentWidth" : 4,
  \ "ColumnLimit" : 100,
  \ "AccessModifierOffset" : -4,
  \ "AllowShortIfStatementsOnASingleLine" : "false",
  \ "AllowShortFunctionsOnASingleLine" : "false",
  \}

" shortcuts for autoformatting the entire file: Ctrl+j
inoremap <C-j> <Esc>:ClangFormat<CR>a
nnoremap <C-j> <Esc>:ClangFormat<CR>



" ################ A ################################

" A - switching between files

" header / source
nnoremap <F4> :A<CR>
inoremap <F4> <ESC>:A<CR>a

" file under cursor
nnoremap <F2> :IH<CR>
inoremap <F2> <ESC>:IH<CR>
