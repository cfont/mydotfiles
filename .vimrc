
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" get rid of stuff that Vim does to be vi compatible
set nocompatible

" prevent some security exploits that have to do with modelines
set modelines=0

" set all tabs to expand to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set smarttab

" common basic behaviors
" relativenumber displays how far away each line is from current one
" undofile creates <FILENAME>.un~ which contains undo info even after you close and reopen a file
set encoding=utf-8
set scrolloff=3
set autoindent
set copyindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile
set history=1000
set undoreload=10000
set lazyredraw
set splitbelow
set splitright
set title
set dictionary=/usr/share/dict/words


" change the <leader> key to be comma
let mapleader = ","
let maplocalleader="\\"

" common searching/moving settings
" fix Vim default regex handling by inserting a \v
" ignorecase and smartcase deal with case-sensitive search
" gdefault applies substituions globally on lines
" incsearch, showmatch, and hlsearch highlight search results
" <leader><space> clears out previous search highlighting
" <tab> makes teh tab key match bracket pairs making moving around easier
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>
nnoremap <tab> %
vnoremap <tab> %

" handle long lines
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1

" show invisible characters with textmate characters
set list
set listchars=tab:▸\ ,eol:¬

" force me to use hjkl instead of arrow keys
" gj and gk works the way I want it to: screen line
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" get rid of F1 as help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" makes ; work the same way as :
nnoremap ; :

" save on losing focus
" au FocusLost * :wa
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * :wincmd =

" strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" fold tag
nnoremap <leader>ft Vatzf

" sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" reselct text that was just pasted
nnoremap <leader>v V`]

" open ~/.vimrc file in a vertically split window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Quicker escaping
inoremap jj <ESC>

" open a new vertical split window
nnoremap <leader>w <C-w>v<C-w>l

" maps <C-[h/j/k/l]> to moving around the split windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Backups
set backup
set noswapfile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Color scheme
syntax on
set background=dark
let g:badwolf_tabline=2
let g:badwolf_html_link_underline=0
colorscheme badwolf

" Reload the colorscheme whenever we write the file.
augroup color_badwolf_dev
    au!
    au BufWritePost badwolf.vim color badwolf
augroup END

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Kill window
nnoremap K :q<cr>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>

" Tabs
nnoremap <leader>( :tabprev<cr>
nnoremap <leader>) :tabnext<cr>

" In visual mode this will disable the "u" key and map "gu" to the same
" functionality
vnoremap u <nop>
vnoremap gu u

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" "Uppercase word" mapping.
"
" This mapping allows you to press <c-u> in insert mode to convert the current
" word to uppercase.  It's handy when you're writing names of constants and
" don't want to use Capslock.
"
" To use it you type the name of the constant in lowercase.  While your
" cursor is at the end of the word, press <c-u> to uppercase it, and then
" continue happily on your way:
"
"                            cursor
"                            v
"     max_connections_allowed|
"     <c-u>
"     MAX_CONNECTIONS_ALLOWED|
"                            ^
"                            cursor
"
" It works by exiting out of insert mode, recording the current cursor
" location
" in the z mark, using gUiw to uppercase inside the current word, moving back
" to
" the z mark, and entering insert mode again.
"
" Note that this will overwrite the contents of the z mark.  I never use it,
" but
" if you do you'll probably want to use another mark.
inoremap <C-u> <esc>mzgUiw`za

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" HTML tag closing
inoremap <C-_> <space><bs><esc>:call InsertCloseTag()<cr>a

" Toggle [i]nvisible characters
nnoremap <leader>i :set list!<cr>

" keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type and never use default behavior
noremap H ^
noremap L $
vnoremap L g_

" Toggle "keep current line in the center of the screen" mode
nnoremap <leader>C :let &scrolloff=999-&scrolloff<cr>

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Quick alignment of text
nnoremap <leader>al :left<CR>
nnoremap <leader>ar :right<CR>
nnoremap <leader>ac :center<CR>


