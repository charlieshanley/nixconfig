set nocompatible
syntax on
filetype plugin indent on
set hidden

" for gitgutter
set updatetime=300 

let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=None

set wildmenu
set showcmd
set hlsearch
set incsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm

set number relativenumber

" revert to absolute numbers in insert mode and when buffer loses focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup end

set notimeout ttimeout ttimeoutlen=200

" <F11> to toggle between paste and nopaste
set pastetoggle=<F11>
set scrolloff=3
set shiftwidth=4
set softtabstop=4
set expandtab
set colorcolumn=80

let mapleader=" "
map Y y$
noremap <C-L> :nohl<CR><C-L>

