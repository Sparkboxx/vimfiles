set nocompatible
call pathogen#infect('~/.vim/bundle')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype-specific indenting, syntax, and plugins
filetype plugin indent on

" COLOR SUPPORT
" Explicitly set 256 color support
syntax on
set t_Co=256
set background=light
set textwidth=120
set cc=+1

colorscheme jellybeans

if has('gui_running')
    set guioptions-=T        " no toolbar
    set guioptions-=l        " no left scrollbar
    set guioptions-=L        " no left scrollbar
    set guioptions-=r        " no right scrollbar
    set guioptions-=R        " no right scrollbar
endif

set guifont=Menlo:h13

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

" highlight current line
set cursorline
set cmdheight=2

" Open new horizontal split windows below current
set splitbelow
" Open new vertical split windows to the right
set splitright
" Set temporary directory (don't litter local dir with swp/tmp files)
set directory=/tmp/

" keep more context when scrolling off the end of a buffer
set scrolloff=5

" Disable backups
set nobackup
set nowritebackup
set noswapfile

" Hide stuffs
set hidden

" make tab completion for files/buffers act like bash
set wildmenu

" show the `best match so far' as search strings are typed:
set incsearch
set ignorecase
set smartcase

" KEY BINDINGS
let mapleader = ","

" RULERS
set ruler


""""""""""""""""""""""""""""""""""""""""
" Shell Settings
""""""""""""""""""""""""""""""""""""""""
set shell=/bin/sh

""""""""""""""""""""""""""""""""""""""""
" KEY BINDINGS
""""""""""""""""""""""""""""""""""""""""

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap ; :

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

"""""""""""""""""""""""""""""""""""""""
" ARDUINO
"""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.pde setf arduino *
au BufNewFile,BufRead *.ino setf arduino *
au BufNewFile,BufReadPost *.pde set filetype=arduino
au BufNewFile,BufReadPost *.ino set filetype=arduino

map <silent> <LocalLeader>am :!make<CR>
map <silent> <LocalLeader>ac :!make clean<CR>
map <silent> <LocalLeader>au :!make upload<CR>
map <silent> <LocalLeader>aa :!make && make upload<CR>

"""""""""""""""""""""""""""""""""""""""
" MARKDOWN
"""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.md set filetype=markdown

"""""""""""""""""""""""""""""""""""""""
" RUBY
"""""""""""""""""""""""""""""""""""""""

" Highlight ruby operators
let ruby_operators = 1

" Turn off rails bits of statusbar
" let g:rails_statusline=0

" Close taglist window if last file is closed
" let Tlist_Exit_OnlyWindow=1

""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMANDS
""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" kill trailing spaces when exiting file
fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%<CR>
map <leader>v :view %%

" For easy buffer toggling
map <Leader>, :b#<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl P
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ctrlp_map = '<Leader>t'
"let g:ctrlp_cmd = 'CtrlP

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoffeeScript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configure Coffeescript folds
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree Helpers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ON THE GO MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open document in Marked
:nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>

"Some help with optimizing .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :edit $MYVIMRC<cr>

"" Stop hitting that escape button all the time
inoremap <c-cr> <esc>

"" Some git commands
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
