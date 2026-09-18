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
let g:loaded_matchparen = 1

" Plug-Vim
call plug#begin()
Plug 'github/copilot.vim'
call plug#end()

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

" Copilot settings
imap <M-C-Right> <Plug>(copilot-accept-word)
imap <M-C-Down> <Plug>(copilot-accept-line)
imap <M-C-Left> <Plug>(copilot-next)
imap <M-C-Up> <Plug>(copilot-suggest)
imap <M-C-BS> <Plug>(copilot-dismiss)
