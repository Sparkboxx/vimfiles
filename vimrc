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
set textwidth=80
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
"set wildmenu

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
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! PromoteToLet()
  ":normal! dd
  ":exec '?^\s*it\>'
  ":normal! P
  ":.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  ":normal ==
"endfunction
":command! PromoteToLet :call PromoteToLet()
":map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --no-color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

map <leader>q :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>
"map <leader>c :w\|:!script/features<cr>
"map <leader>w :w\|:!script/features --profile wip<cr>

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

"" Configure Vim Gist by our friend Mats
let g:gist_post_private = 1
let g:gist_show_privates = 1
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'pbcopy'

"" Some git commands
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
