"        _                      _         _               
" __   _(_)_ __ ___  _ __ ___  | | ____ _(_)___  ___ _ __ 
" \ \ / / | '_ ` _ \| '__/ __| | |/ / _` | / __|/ _ \ '__|
"  \ V /| | | | | | | | | (__  |   < (_| | \__ \  __/ |   
" (_)_/ |_|_| |_| |_|_|  \___| |_|\_\__,_|_|___/\___|_|   
"                                                         
" start_symbol_kaiserqzyue
" We add a empty line above to make sure the script append it correctly.

" set scrolloff to make you can see the non-exist lines of files
" set scrolloff=999 will let your cursor line always be in the middle.
" but when it reach the bottom, the cursor line will not be the middle,
" use this below can figure it out, make your cursor always the middle,
" this will inconvenient for looking code
" augroup VCenterCursor
" au!
" au BufEnter,WinEnter,WinNew,VimResized *,*.*
"     \ let &scrolloff=winheight(win_getid())/2
" augroup END

" try to show part of the last line when the window is too small to show the whole last line
" rather than useing @ to substitute
set display=lastline

set scrolloff=5

" show tips of column 100
set cc=100

" set fold method for folding code.
set foldmethod=syntax
set foldlevel=99
" use indent to fold code in python files
autocmd Filetype python setlocal foldmethod=indent

" Those are for cursor to be changeable between normal mode and insert mode.
let &t_SI.="\e[5 q"
let &t_SR.="\e[3 q"
let &t_EI.="\e[1 q"

" This is to make <ESC> quicker
set ttimeoutlen=0

" set leader be space
let mapleader=" "

" move the selected content up and down
" TODO: update this to support [count]J and [count]K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" set <leader>sc to turn on or off spell check
nnoremap <leader>sc :set spell!<CR>

" Set no compatible mode for vim
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" set utf-8 as default encoding
scriptencoding utf-8
set encoding=utf-8

" set list chars
set list
set listchars=tab:»·,trail:·,lead:·

" set your working directory is where current file is.
set autochdir

" This is to set cursor where it was when the file is closed last time.
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Turn on syntax highlight.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Set line number
set number
" Set relative line number
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2
" Always show the tab line
set showtabline=2

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" highlight search
" use <LEADER><CR> to close search highlight
exec "nohlsearch"
set hlsearch
nnoremap <LEADER><CR> :nohlsearch<CR>

" use Y to copy to the end of current line
nnoremap Y y$

" NOTE: I've found a new solution for this (copy and paste with windows using
" wsl vim). After 2021, wsl has internal gui app,  which is called wslg,
" using windows to show gui apps, so now the system clipboard can be used.
" make sure you have sudo apt install vim-gtk
nnoremap <LEADER>Y "+y$
nnoremap <LEADER>y "+y
xnoremap <LEADER>y "+y
nnoremap <LEADER>p "+p
nnoremap <LEADER>P "+P
xnoremap <LEADER>p "+p
xnoremap <LEADER>P "+P
" copy the whole file is used very often, so we add a new bind for this.
" this use mark to go back
nnoremap <LEADER>ya mzggVG"+y`z:delmark z<CR>

" Unbind some useless/annoying default key bindings.
" 'Q' in normal mode enters Ex mode. You almost never want this.
" we map Q to be :q!
nnoremap Q :q!<CR>

" we cannot set <TAB>, because this will affect ^I
" nnoremap <TAB> :tabnext<CR>
" nnoremap <S-TAB> :tabprev<CR>

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support.
" You should avoid relying on this too much, but it can sometimes be convenient.
set mouse+=a

" show cursor line to let you know where are you now more efficiently
set cursorline

" show command
set showcmd

" wild menu for tab search
set wildmenu

" set indentation 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

" show one long line in many lines, rather than infinitely elongating.
set wrap

" never auto split
set tw=0

" when in wrap lines, j, k, 0, and $ can move in wrap lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <silent> <expr> 0 (v:count == 0 ? 'g0' : '0')
noremap <silent> <expr> $ (v:count == 0 ? 'g$' : '$')

" set ^S to be :w
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>

" set S to be :wq
nnoremap S :wq<CR>

" set <C> + h, j, k and l to be split left, down, up, right.
" set <leader> h, j, k and l to move cursor between Windows.
" set <leader>H, J, K, L to move current window to left, down, up, right
" set <leader>T to let current window be a new tab
nnoremap <LEADER>h :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
nnoremap <LEADER>l :set splitright<CR>:vsplit<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <LEADER>H <C-w>H
nnoremap <LEADER>J <C-w>J
nnoremap <LEADER>K <C-w>K
nnoremap <LEADER>L <C-w>L
nnoremap <LEADER>T <C-w>T

" set up to add size of current window, down to minus size
" set right to add size of current window, left to minus size
nnoremap <Up> :res +5<CR>
nnoremap <Down> :res -5<CR>
nnoremap <Left> :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>

" set <leader>t to create new tab
nnoremap <LEADER>t :tabnew<CR>

" Now we use <LEADER>n and <LEADER>b to got next and back
" and <LEADER>nubmer to go specified tab.
nnoremap <LEADER>b :tabprev<CR>
nnoremap <LEADER>n :tabnext<CR>
nnoremap <LEADER>1 1gt
nnoremap <LEADER>2 2gt
nnoremap <LEADER>3 3gt
nnoremap <LEADER>4 4gt
nnoremap <LEADER>5 5gt
nnoremap <LEADER>6 6gt
nnoremap <LEADER>7 7gt
nnoremap <LEADER>8 8gt
nnoremap <LEADER>9 9gt

set completeopt=popup

source ~/.vim/vim_plugin_config/vimplug_config.vim
source ~/.vim/vim_plugin_config/copilot_config.vim
source ~/.vim/vim_plugin_config/leaderf_config.vim
source ~/.vim/vim_plugin_config/nerdtree_config.vim
source ~/.vim/vim_plugin_config/vimone_config.vim
source ~/.vim/vim_plugin_config/vimpolyglot_config.vim
source ~/.vim/vim_plugin_config/undotree_config.vim
source ~/.vim/vim_plugin_config/tagbar_config.vim
source ~/.vim/vim_plugin_config/nerdcommenter_config.vim
source ~/.vim/vim_plugin_config/vimwhichkey_config.vim
source ~/.vim/vim_plugin_config/nerdtreegitplugin_config.vim
source ~/.vim/vim_plugin_config/markdownpreview_config.vim
source ~/.vim/vim_plugin_config/vimwiki_config.vim
source ~/.vim/vim_plugin_config/coc_config.vim
source ~/.vim/vim_plugin_config/indentline_config.vim
source ~/.vim/vim_plugin_config/autopairs_config.vim
source ~/.vim/vim_plugin_config/vimsurround_config.vim
source ~/.vim/vim_plugin_config/tabular_config.vim
source ~/.vim/vim_plugin_config/markdownhelper_config.vim
source ~/.vim/vim_plugin_config/pythonmode_config.vim
source ~/.vim/vim_plugin_config/vimdevicons_config.vim
source ~/.vim/vim_plugin_config/vimairline_config.vim

" Compile function
func! CompileRun()
    write
    if &filetype == 'c'
        !clear; gcc -g -Wall % -o %<.out && echo RUNNING && time ./%<.out
    elseif &filetype == 'cpp'
        !clear; g++ -g -Wall -std=c++17 % -o %<.out && echo RUNNING && time ./%<.out
    elseif &filetype == 'java'
        !clear; javac % && echo RUNNING && time java %<
    elseif &filetype == 'sh'
        !clear; time ./%
    elseif &filetype == 'python'
        !clear; time python3 %
    elseif &filetype == 'html'
        !wslview % &
    elseif &filetype == 'markdown'
        MarkdownPreviewToggle
    elseif &filetype == 'vimwiki'
        MarkdownPreviewToggle
    endif
endfunc
nnoremap <LEADER>r :call CompileRun()<CR>

" set empty file type be none.
function! SetFiletypeNewBuffer()
  if @% == ""
    :set filetype=none
  endif
endfunction
autocmd BufEnter * :call SetFiletypeNewBuffer()

" Note that this must be at the bottom,
" and I don't know why, it seems that some plugins will disable something.
" close the annoying auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" we add a empty line below to make sure the script append it correctly.
" end_symbol_kaiserqzyue

