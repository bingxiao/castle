" Pathogen
filetype off
call pathogen#runtime_append_all_bundles()

" Filetypes
filetype plugin indent on
syntax enable

" Spaces/tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" General
set encoding=utf-8
set scrolloff=3
set autoindent
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

" Reference dictionaries and thesaurus
set thesaurus+=~/.dicts/mthesaur.txt

" Store swap, backup, and undo files in ~/.vim
" For more info, see http://stackoverflow.com/q/4331812
set undofile
set dir=~/.vim/swap//
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//

" <leader> and <ESC>
inoremap jk <ESC>
let mapleader = ","

" Search and moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk

" Long lines
set wrap
set textwidth=79
set formatoptions=qrn1
" too annoying - set colorcolumn=85

" More settings - TODO: Categorize
" Pretty invisible chars 
set listchars=tab:▸\ ,eol:¬
" Save files when vim loses focus
au FocusLost * :wa
"Automatically change current directory to that of the file in the buffer  
autocmd BufEnter * cd %:p:h
"Hide MacVim toolbar by default  
set go-=T 
" Source the vimrc file after saving it. This way, you don't have to reload Vim to see the changes.  
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc  
augroup END  

"
" Leader commands
"
" Strip whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR> 
" Ack
nnoremap <leader>a :Ack
" Fold tag
nnoremap <leader>ft Vatzf
" Sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" Hard-wrap text
nnoremap <leader>q gqip
" Re-select pasted text
nnoremap <leader>v V`]
" Edit .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" Toggle relativenumber and list [invsible whitepsace]
nnoremap <leader>r :set relativenumber!<cr>
nnoremap <leader>i :set list!<cr>
" Save file
nnoremap <leader>w :w<CR>
" Split screens
" New vsplit
nnoremap <leader>v <C-w>v<C-w>l
" TODO: leader for <C-w>o (close other splits)
" Switch splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Theme
set background=dark
let g:solarized_termtrans=1

" Cursor-shape 
if &term =~ "xterm"
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

