func! vundle#config#bundle(arg, ...)
  let bundle = vundle#config#init_bundle(a:arg, a:000)
  call s:rtp_rm_a()
  call add(g:bundles, bundle)
  call s:rtp_add_a()
endf

func! vundle#config#init()
  if !exists('g:bundles') | let g:bundles = [] | endif
  call s:rtp_rm_a()
  let g:bundles = []
endf

func! vundle#config#require(bundles)
  for b in a:bundles
    call s:rtp_add(b.rtpath())
    call s:rtp_add(g:bundle_dir)
    " TODO: it has to be relative rtpath, not bundle.name
    exec 'runtime! '.b.name.'/plugin/*.vim'
    exec 'runtime! '.b.name.'/after/*.vim'
    call s:rtp_rm(g:bundle_dir)
  endfor
endf

func! vundle#config#init_bundle(name, opts)
  let opts = extend(s:parse_options(a:opts), s:parse_name(substitute(a:name,"['".'"]\+','','g')))
  return extend(opts, copy(s:bundle))
endf

func! s:parse_options(opts)
  " TODO: improve this
  if len(a:opts) != 1 | return {} | endif

  if type(a:opts[0]) == type({})
    return a:opts[0]
  else
    return {'rev': a:opts[0]}
  endif
endf

func! s:parse_name(arg)
  let arg = a:arg
  if    arg =~ '^\s*\(gh\|github\):\S\+'
  \  || arg =~ '^\w\+/[^/]\+$'
    let uri = 'https://github.com/'.split(arg, ':')[-1]
    let name = substitute(split(uri,'\/')[-1], '\.git\s*$','','i')
  elseif arg =~ '^\s*\(git@\|git://\)\S\+' 
  \   || arg =~ '(file|https\?)://'
  \   || arg =~ '\.git\s*$'
    let uri = arg
    let name = split( substitute(uri,'/\?\.git\s*$','','i') ,'\/')[-1]
  else
    let name = arg
    let uri  = 'https://github.com/vim-scripts/'.name.'.git'
  endif
  return {'name': name, 'uri': uri }
endf

func! s:rtp_rm_a()
  call filter(copy(g:bundles), 's:rtp_rm(v:val.rtpath())')
endf

func! s:rtp_add_a()
  call filter(reverse(copy(g:bundles)), 's:rtp_add(v:val.rtpath())')
endf

func! s:rtp_rm(dir)
  exec 'set rtp-='.a:dir
  exec 'set rtp-='.expand(a:dir.'/after')
endf

func! s:rtp_add(dir)
  exec 'set rtp^='.a:dir
  exec 'set rtp+='.expand(a:dir.'/after')
endf

let s:bundle = {}

func! s:bundle.path()
  return join([g:bundle_dir, self.name], '/')
endf

func! s:bundle.rtpath()
  return has_key(self, 'rtp') ? join([self.path(), self.rtp], '/') : self.path()
endf
