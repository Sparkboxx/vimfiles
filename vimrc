set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

" Bundles:
Bundle "L9"
Bundle "FuzzyFinder"
Bundle "rails.vim"
Bundle "ack.vim"
Bundle "git://git.wincent.com/command-t.git"
Bundle "https://github.com/altercation/vim-colors-solarized.git"
Bundle "https://github.com/tpope/vim-fugitive.git"

" General vim config
syntax on

" Use solarized colorscheme
set background=light
colorscheme solarized

" Personal keybindings
