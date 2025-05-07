filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'wakatime/vim-wakatime'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set tabstop=2
set shiftwidth=2
set number
set noexpandtab
colorscheme slate

" Enable relative number in normal mode
set relativenumber
augroup RelativeNumber
  autocmd!
  autocmd InsertEnter * set norelativenumber
  autocmd InsertLeave * set relativenumber
augroup END

augroup ExitToNormal
	autocmd!
	autocmd FocusLost,TabLeave * stopinsert
	autocmd FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")
augroup END
