" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" vim-plug
call plug#begin('~/.vim/plugged')

" List plugins here
" e.g. Plug 'repo/name'

Plug 'airblade/vim-gitgutter'                              " shows a git diff in the gutter

" One Dark syntax highlighting
Plug 'rakr/vim-one'

call plug#end()

syntax enable
colorscheme one
set background=dark
set number
