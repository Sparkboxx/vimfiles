set rtp+=~/.vim/vundle.git/
call vundle#rc()

" Bundles:
Bundle "L9"
" Bundle "FuzzyFinder"
Bundle "rails.vim"
Bundle "ack.vim"
Bundle "git://git.wincent.com/command-t.git"
Bundle "https://github.com/altercation/vim-colors-solarized.git"
Bundle "https://github.com/tpope/vim-git.git"
Bundle "https://github.com/tpope/vim-fugitive.git"
Bundle "https://github.com/tpope/vim-surround.git"
Bundle "https://github.com/scrooloose/nerdcommenter.git"
Bundle "https://github.com/scrooloose/nerdtree.git"
Bundle "https://github.com/vim-scripts/VimClojure.git"
Bundle "tlist.vim"

" UTF-8 All the way
scriptencoding utf-8

" Use zsh.
set shell=zsh

" Enable filetype-specific indenting, syntax, and plugins
filetype plugin indent on
set nocompatible
syntax on

" Disable bell.
set vb t_vb=

" Set to auto read when a file is changed from the outside
set autoread

" COLOR SUPPORT

" Explicitly set 256 color support
" set t_Co=256

colorscheme solarized

" GUI FONT
set guifont=Espresso\ Mono:h14

" TEXT SETTINGS

" Disable line wrapping
set nowrap
" set wrap

" use indents of 2 spaces, and have them copied down lines:
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" line numbers
set number
set numberwidth=3

" kill trailing spaces when exiting file
autocmd BufWritePre * :%s/\s\+$//e

" KEY BINDINGS

let mapleader = ","

" WINDOW SPLITTING

" Open new horizontal split windows below current
set splitbelow

" Open new vertical split windows to the right
set splitright


" Set temporary directory (don't litter local dir with swp/tmp files)
set directory=/tmp/

" Use the tab complete menu
set wildmenu

" KEYBINDINGS

" Quick, jump out of insert mode while no one is looking
" imap ii <Esc>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$


" CUSTOM PLUGINS

" FuzzyFinder Path Splitting (ala textmate)
let g:fuf_splitPathMatching = 1

" Write stats to file
let g:fuf_infoFile = '~/.vim-fuf'
let g:fuf_learningLimit = 500

" CUSTOM FUNCTIONS

" Add RebuildTagsFile function/command
function! s:RebuildTagsFile()
  !ctags -R --exclude=coverage --exclude=files --exclude=public --exclude=log --exclude=tmp --exclude=vendor *
endfunction
command! -nargs=0 RebuildTagsFile call s:RebuildTagsFile()


" STATUS BAR CONFIG

set laststatus=2
set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
set statusline+=]
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset


" NERDTree CONFIGURATION

" Enable nice colors
let NERDChristmasTree = 1

" Make it easy to see where we are
let NERDTreeHighlightCursorline = 1

" Make bookmarks visible
let NERDTreeShowBookmarks = 1

" Show hidden files
let NERDTreeShowHidden = 1

" Don't hijack NETRW
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.$', '\~$']

" Make F2 open NERDTree
nmap <F2> :NERDTreeToggle<CR>


" Search Config

" show the `best match so far' as search strings are typed:
set incsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" <leader>f to startup an ack search
map <leader>a :Ack<Space>


" RUBY

" Highlight ruby operators
let ruby_operators = 1

" Turn off rails bits of statusbar
let g:rails_statusline=0

" Clojure config

" Enable gorilla for the lisp on the jvm
let vimclojure#WantNailgun=1

" Highlight built-in clojure functions
let g:clj_highlight_builtins = 1

" Paren Rainbow (diff colors for diff nestings)
let g:clj_paren_rainbow = 1

" Auto added used namespaces, generally be awesome
let vimclojure#DynamicHighlighting=1
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1

" Make taglist use lisp language def for clojure code
let tlist_clojure_settings = 'lisp;f:function'

" Close taglist window if last file is closed
let Tlist_Exit_OnlyWindow=1

" NERDCommenter
let NERDDefaultNesting = 0
let NERDRemoveExtraSpaces = 1
let NERDSpaceDelims = 1

" NERDTree

" Enable nice colors
let NERDChristmasTree = 1

" Make it easy to see where we are
let NERDTreeHighlightCursorline = 1

" Make bookmarks visible
let NERDTreeShowBookmarks = 1

" Show hidden files
let NERDTreeShowHidden = 1
" Don't hijack NETRW
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.$', '\~$']

" NeoComplCache
" let g:NeoComplCache_EnableAtStartup=1


" AUTOCOMMANDS

function! CustomClojureSettings()
  set filetype=clojure
endfunction

" function! CustomJsonSettings()
  " autocmd BufRead *.json set filetype=json
  " au! Syntax json source ~/Downloads/json.vim
  " autocmd FileType json set equalprg=json_reformat
  " autocmd FileType json set makeprg=jsonval\ %
  " autocmd FileType json set errorformat=%E%f:\ %m\ at\ line\ %l,%-G%.%#
" endfunction

function! CustomMarkdownSettings()
  set filetype=mkd
endfunction

augroup SpicyAutoCommands
  autocmd BufEnter,BufWritePost *.clj   call CustomClojureSettings()
  autocmd BufEnter *.markdown call CustomMarkdownSettings()
  " autocmd BufRead *.json call CustomJsonSettings()
  " autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  " autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  " autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
augroup END

" Mappings for quick split navigation
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Remove toolbar in MacVim
set guioptions-=T

" Make other people absolutely hate me
" Disable arrow keys
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>


" Disable backups
set nobackup
set nowritebackup
set noswapfile

" Matching for trailing whitespace
match Todo /\s\+$/

""" Personal keybindings
" Reload vim settings
nmap <silent> <Leader>§ :source ~/.vimrc<CR>
nmap <silent> <Leader>± :e ~/.vimrc<CR>

" Close current split
nmap <silent> <Leader>c :q!<CR>

" Map F1 to escape
map <F1> <Esc>
imap <F1> <Esc>

