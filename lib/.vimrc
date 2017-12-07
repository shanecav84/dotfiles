" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set laststatus=2

" vim-plug
call plug#begin('~/.vim/plugged')

" List plugins here
" e.g. Plug 'repo/name'

Plug 'airblade/vim-gitgutter'                              " shows a git diff in the gutter

" One Dark syntax highlighting
Plug 'rakr/vim-one'

Plug 'tpope/vim-endwise'

Plug 'ajh17/VimCompletesMe'

call plug#end()

syntax enable
colorscheme one
set background=dark
set number

set autoindent                                             " Copy indent from current line when starting a new line
set smartindent                                            " Inserts one extra level of indentation in some cases
set expandtab                                              " <TAB> will insert 'softtabstop' amount of spaces
set shiftwidth=2                                           " Number of auto-indent spaces
set softtabstop=2                                          " Number of spaces per tab while editing
set tabstop=2                                              " Number of spaces per tab in a file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
