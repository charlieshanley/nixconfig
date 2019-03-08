set nocompatible
syntax on
filetype plugin indent on
set hidden

" for gitgutter
set updatetime=300 

" for NERDTree -----
" Open NERDTree when vim starts up
autocmd vimenter * NERDTree 
" Toggle on Ctrl-n
map <C-n> :NERDTreeToggle<CR>
" Close vim if only remaining window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif 

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

fun! ExceptNerdtree(cmd)
    if &ft == "nerdtree"
        return
    endif
    execute a:cmd
endfun
" revert to absolute numbers in insert mode and when buffer loses focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * call ExceptNerdtree("set relativenumber")
  autocmd BufLeave,FocusLost,InsertEnter   * call ExceptNerdtree("set norelativenumber")
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

" clear search highlight
nnoremap <leader>l :nohl<CR><C-L> 

" Navigate between splits with Ctrl-<hjkl>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" open splits
nnoremap <leader>\ :vnew<CR>
nnoremap <leader>- :new<CR>
