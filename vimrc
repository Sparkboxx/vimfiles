set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Bundles:
Bundle "gmarik/vundle"
Bundle "L9"

" Navigation stuff
Bundle "git://git.wincent.com/command-t.git"
Bundle "https://github.com/scrooloose/nerdtree.git"
Bundle "Tagbar"
Bundle "ack.vim"
Bundle "minibufexpl.vim"

" DVCS stuff
Bundle "https://github.com/tpope/vim-git.git"
Bundle "https://github.com/tpope/vim-fugitive.git"

" Code editing stuff
Bundle "https://github.com/tpope/vim-surround.git"
Bundle "https://github.com/scrooloose/nerdcommenter.git"

" Clojure/Lisp stuff
Bundle "Vimclojure"
" Bundle "slimv.vim"

" Ruby stuff"
Bundle "rails.vim"

" look-n-feel
Bundle "molokai"

" Other stuff
Bundle "vim-coffee-script"

" UTF-8 All the way
scriptencoding utf-8

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
set t_Co=256

colorscheme molokai
" Remove toolbar in MacVim
if has("gui_running")
  set noantialias
  set guifont=Monaco:h10
  set guioptions-=T        " no toolbar
  set guioptions-=l        " no left scrollbar
  set guioptions-=L        " no left scrollbar
  set guioptions-=r        " no right scrollbar
  set guioptions-=R        " no right scrollbar
end

" TEXT SETTINGS
" Disable line wrapping
set nowrap

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

" Close taglist window if last file is closed
let Tlist_Exit_OnlyWindow=1

" NERDCommenter
let NERDDefaultNesting = 0
let NERDRemoveExtraSpaces = 1
let NERDSpaceDelims = 1

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

" AUTOCOMMANDS
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

function! CustomClojureSettings()
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
nmap <silent> <Leader>qq :q<CR>

" Map F1 to escape
map <F1> <Esc>
imap <F1> <Esc>

" For fugitive
nmap <silent> <Leader>gs :Gstatus<CR>
nmap <silent> <Leader>gcc :Gcommit<CR>

" For ruby method navigation
map <Leader>[ [m
map <Leader>] ]M
map <C-n> ]m

" For command-t
map <Leader>ft :CommandTFlush<CR>

" For email
augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" For Rubytest

let g:rubytest_in_quickfix = 1
let g:rubytest_cmd_test = "ruby %p"
let g:rubytest_cmd_testcase = "ruby %p -n '/%c/'"
let g:rubytest_cmd_spec = "bundle exec spec -f specdoc %p"
let g:rubytest_cmd_example = "bundle exec spec -f specdoc %p -e '%c'"
let g:rubytest_cmd_feature = "bundle exec cucumber %p"
let g:rubytest_cmd_story = "bundle exec cucumber %p -n '%c'"

map <Leader>r <Plug>RubyTestRun " change from <Leader>t to <Leader>r
map <Leader>R <Plug>RubyFileRun " change from <Leader>T to <Leader>R
map <Leader>\ <Plug>RubyTestRunLast " change from <Leader>l to <Leader>\

" Hide stuffs
set hidden

" For scratch buffer
map <Leader>` :ScratchOpen<CR>

" For easy buffer toggling
map <Leader>, :b#<CR>
