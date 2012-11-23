" vim:set et foldmethod=marker:
" Setup neobundle.vim {{{
set nocompatible
filetype off

if has('vim_starting')
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  syntax enable
endif

call neobundle#rc(expand('~/.vim/bundle'))
" }}}

" Plugins {{{
" Text object {{{
NeoBundle 'kana/vim-textobj-user'

NeoBundle 'h1mesuke/textobj-wiw'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'thinca/vim-textobj-comment'
" }}}

" Help {{{
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'thinca/vim-ref'
" }}}

" Unite {{{
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'sgur/unite-qf'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'osyo-manga/unite-filetype'
NeoBundle 'osyo-manga/unite-quickrun_config'
NeoBundle 'osyo-manga/unite-fold'
NeoBundle 'tsukkee/unite-tag'
" }}}

" Input {{{
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'tpope/vim-surround'
NeoBundle 't9md/vim-surround_custom_mapping'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'tpope/vim-commentary'
" }}}

" Language {{{
NeoBundle 'bbommarito/vim-slim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'hallison/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'motemen/hatena-vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'juvenn/mustache.vim'
NeoBundle 'davidoc/taskpaper.vim'
" }}}

" UI {{{
NeoBundle 'Lokaltog/vim-powerline', 'develop'
NeoBundle 'nathanaelkane/vim-indent-guides'
" }}}

" Colors {{{
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'git@github.com:aereal/vim-magica-colors.git',
      \ { 'base' : '~/repos/@aereal' }
NeoBundle 'nanotech/jellybeans.vim'
" }}}

" Utils {{{
" }}}

" Files {{{
NeoBundle 'kana/vim-altr'
NeoBundle 'kana/vim-gf-user'
NeoBundle 'kana/vim-gf-diff'
NeoBundle 'thinca/vim-partedit'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'sudo.vim'
" }}}

" Misc. {{{
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'mac' : 'make -f make_mac.mak',
      \   'unix' : 'make -f make_unix.mak',
      \   },
      \ }
NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'int3/vim-extradite'

NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'sjl/gundo.vim'
" }}}

" Move {{{
NeoBundle 'Lokaltog/vim-easymotion'
" }}}

filetype plugin indent on
" }}}

" Configurations {{{
set nocompatible
set hidden
set history=100
set autoread
set autoindent
set nosmartindent
set nocindent
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932,ucs-bom,default,latin1
set encoding=utf-8
set termencoding=utf-8
set fileformats=unix,dos,mac
set langmenu=none " メニューをローカライズしない
lang en_US.UTF-8
set wildmenu
set wildmode=list:longest,full
set nobackup
set swapfile
set directory=~/.vim/swp
set laststatus=2
set number
set ruler
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set scrolloff=100000 " 常にカーソルのある行を中心に (したい)
set splitbelow
set modeline
set showcmd
set showmode
set shortmess+=I
set ambiwidth=double
set backspace=indent,eol,start
set list
set listchars=tab:>.,precedes:<,extends:>,eol:↵
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
set formatoptions-=ro
set ttyfast

if has('conceal')
  set conceallevel=2 concealcursor=i
endif

if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

if has('clipboard')
  set clipboard=unnamed,autoselect
endif

" }}}

" Tabpage {{{
function! s:tabpage_label(n) " {{{
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  let bufnrs = tabpagebuflist(a:n)
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif

  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]
  let fname = pathshorten(bufname(curbufnr))
  let label = no . mod . sp . fname

  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction " }}}

function! MakeTabLine() " {{{
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let separator = ' | '
  let tabpages = join(titles, separator) . separator . '%#TabLineFill#%T'
  let info = ''
  let info .= cfi#format('%s()' . separator, '')
  return tabpages . '%=' . info
endfunction " }}}

set showtabline=2
set guioptions-=e
set tabline=%!MakeTabLine()
" }}}

" Key mappings {{{
let mapleader   = ';'
let g:mapleader = ';'

nnoremap <Leader><Space> :update<CR>
nnoremap <ESC><ESC>      :nohlsearch<CR>

inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', '=')
" }}}

" Command-line Window http://vim-users.jp/2010/07/hack161/ {{{
nnoremap   <sid>(command-line-enter) q:
xnoremap   <sid>(command-line-enter) q:
nnoremap   <sid>(command-line-norange) q:<C-u>
nmap     : <sid>(command-line-enter)
xmap     : <sid>(command-line-enter)

autocmd CmdwinEnter * call s:init_cmdwin()

function! s:init_cmdwin() "{{{
  nnoremap <buffer>       q     :<C-u>quit<CR>
  nnoremap <buffer>       <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr> <CR>  pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr> <C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr> <BS>  pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr> <C-h> col('.') == 1 ? "\<ESC>:quit\<CR>" : pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr> :     col('.') == 1 ? "VimProcBang " : col('.') == 2 && getline('.')[0] == 'r' ? "<BS>VimProcRead " : ":"
  inoremap <buffer><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  setlocal nonumber
  startinsert!
endfunction " }}}
" }}}

" Adjust splitted-window width http://vim-users.jp/2009/07/hack42/ {{{
nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
nnoremap <C-w>j <C-w>j:call <SID>good_width()<CR>
nnoremap <C-w>k <C-w>k:call <SID>good_width()<CR>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>

function! s:good_width() "{{{
  if winwidth(0) < 80
    vertical resize 80
  endif
endfunction " }}}
" }}}

" autocmd {{{
" screenに編集中のファイル名を出す
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%:t\\"' | endif

" sh {{{
autocmd FileType sh inoremap <buffer><expr> = smartchr#loop('=', ' != ')
" }}}

" io {{{
autocmd FileType io inoremap <buffer><expr> = smartchr#loop(' := ', ' = ', ' == ', ' ::= ')
" }}}

" javascript {{{
autocmd FileType javascript inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ')
autocmd FileType javascript inoremap <buffer><expr> \ smartchr#one_of('function ', '\')
autocmd FileType javascript nnoremap <silent><buffer> <Space>kj :<C-u>Unite -start-insert -default-action=split ref/javascript<CR>
autocmd FileType javascript nnoremap <silent><buffer> <Space>kq :<C-u>Unite -start-insert -default-action=split ref/jquery<CR>
" }}}

" ruby {{{
autocmd FileType ruby    inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', ' != ')
autocmd FileType ruby    inoremap <buffer><expr> , smartchr#loop(', ', ' => ', ',')
autocmd FileType ruby    nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/refe<CR>
autocmd FileType ruby    nnoremap <silent><buffer> <S-k>    :<C-u>UniteWithCursorWord -default-action=split ref/refe<CR>

autocmd BufEnter */.gemrc set ft=yaml
" }}}

" coffee {{{
autocmd FileType    coffee inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
autocmd FileType    coffee inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')
autocmd ColorScheme *      hi! link CoffeeSpecialVar Constant
" }}}

" haskell {{{
autocmd FileType haskell setlocal et
autocmd FileType haskell inoremap <buffer><expr> = smartchr#loop(' = ', '=')
autocmd FileType haskell inoremap <buffer><expr> . smartchr#one_of(' -> ', '.')
autocmd FileType haskell inoremap <buffer><expr> , smartchr#one_of(' <- ', ',')
" }}}

" perl {{{
autocmd FileType perl    inoremap <buffer><expr> . smartchr#one_of('.', '->', '.')
autocmd FileType perl    inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
autocmd FileType perl    inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' != ', ' =~ ', ' !~ ', ' <=> ', '=')
autocmd FileType perl    nnoremap <silent><buffer> <Space>k :<C-u>Unite -start-insert -default-action=split ref/perldoc<CR>
autocmd FileType perl    nnoremap <silent><buffer> <S-k> :<C-u>UniteWithCursorWord -default-action=split ref/perldoc<CR>
autocmd BufEnter *.tt    set ft=tt2
autocmd BufEnter */t/*.t set ft=perl.tap
" }}}

" vim {{{
autocmd FileType vim inoremap <buffer> = =
" }}}

" markdown {{{
autocmd FileType markdown setlocal et ts=4 sts=4 sw=4
" }}}

" haml {{{
autocmd FileType haml inoremap <buffer><expr> , smartchr#one_of(', ', ' => ', ',')
" }}}

" nginx {{{
autocmd BufEnter */nginx/*.conf set ft=nginx
autocmd BufEnter */*.nginx.conf set ft=nginx
" }}}

" html {{{
  autocmd FileType html inoremap <buffer> = =
" }}}

" Hatena projects {{{
autocmd BufEnter */@hatena/*          setlocal et ts=4 sts=4 sw=4
autocmd BufEnter */@hatena/*.html.erb setlocal ts=2 sts=2 sw=2
autocmd BufEnter */@hatena/*.html     setlocal ts=2 sts=2 sw=2
autocmd BufEnter */@hatena/*.html.tt  setlocal ts=2 sts=2 sw=2
autocmd BufEnter */@hatena/*.html     set ft=tt2html
autocmd BufEnter */@hatena/*.tt       set ft=tt2html
" }}}

" http://d.hatena.ne.jp/thinca/20090530/1243615055
augroup AutoCursorLine
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorHold,CursorHoldI,WinEnter * setlocal cursorline
augroup END
" }}}

" Plugin Configurations {{{
" neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_temporary_dir = '~/.vim/.neocon'
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_omni_functions = {
      \ 'ruby' : 'rubycomplete#Complete',
      \ }
let g:neocomplcache_vim_completefuncs = {
      \ 'Ref' : 'ref#complete',
      \ 'Unite' : 'unite#complete_source',
      \}

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

inoremap <expr><CR>   neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-x><C-f>  neocomplcache#manual_filename_complete()
" }}}
" neosnippet {{{
let g:neosnippet#disable_select_mode_mappings = 0
let g:neosnippet#snippets_directory = '~/.vim/snippets'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like
imap <expr><TAB> neosnippet#expandable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \ : "\<TAB>"
" }}}
" syntastic {{{
let g:syntastic_auto_loc_list  = 2
let g:syntastic_perl_efm_program = $HOME . '/.vim/bin/efm_perl.pl'
" }}}
" fugitive {{{
nnoremap [fugitive] <Nop>
nmap git [fugitive]

nnoremap [fugitive]s :<C-u>Gstatus<CR>
nnoremap [fugitive]c :<C-u>Gcommit<CR>
nnoremap [fugitive]C :<C-u>Gcommit --amend<CR>
nnoremap [fugitive]b :<C-u>Gblame<CR>
nnoremap [fugitive]a :<C-u>Gwrite<CR>
nnoremap [fugitive]d :<C-u>Gdiff<CR>
nnoremap [fugitive]D :<C-u>Gdiff --staged<CR>

autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}
" surround_custom_mapping {{{
let g:surround_custom_mapping = {}
let g:surround_custom_mapping.ruby  = {
  \ '#': "#{\r}",
  \ '3': "#{\r}",
  \ '5': "%(\r)",
  \ '%': "%(\r)",
  \ 'w': "%w(\r)",
  \ }
let g:surround_custom_mapping.eruby = {
  \ '-': "<% \r %>",
  \ '=': "<%= \r %>",
  \ '#': "#{\r}",
  \ }
let g:surround_custom_mapping.tt2 = {
      \ '%': "[% \r %]",
      \ }
" }}}
" zencoding-vim {{{
let g:user_zen_leader_key = '<C-e>'
let g:user_zen_settings = {
      \ 'indentation': ' ',
      \ }
" }}}
" ref-vim {{{
let g:ref_jquery_doc_path = $HOME . '/Downloads/jqapi-latest'
let g:ref_jquery_use_cache = 1
let g:ref_cache_dir = $HOME . '/.vim/.ref'
" }}}
" unite-vim {{{
let g:unite_data_directory = '~/.vim/.unite'

nnoremap <SID>[unite] <Nop>
nmap <Space> <SID>[unite]
nnoremap <silent> <SID>[unite]o        :<C-u>UniteWithBufferDir buffer file_mru file file/new<CR>

if has('gui_running')
  nnoremap <silent> <SID>[unite]b        :<C-u>Unite buffer_tab -immediately<CR>
  nnoremap <silent> <SID>[unite]B        :<C-u>Unite buffer -immediately<CR>
else
  nnoremap <silent> <SID>[unite]b        :<C-u>Unite buffer -immediately<CR>
endif

nnoremap <silent> <SID>[unite]O        :<C-u>UniteWithCurrentDir buffer file_mru file file/new<CR>
nnoremap <silent> <SID>[unite].        :<C-u>Unite source<CR>
nnoremap <silent> <SID>[unite]s        :<C-u>Unite session<CR>
nnoremap <silent> <SID>[unite]w        :<C-u>Unite -immediately window:no-current<CR>

nnoremap <silent> / :<C-u>Unite line -buffer-name=search -start-insert<CR>
nnoremap <silent> * :<C-u>UniteWithCursorWord line -buffer-name=search<CR>
nnoremap <silent> n :<C-u>UniteResume search -no-start-insert<CR>

nnoremap <silent> <SID>[unite]t :<C-u>Unite tab<CR>

autocmd FileType unite call s:unite_local_settings()

function! s:unite_local_settings() "{{{
  imap <buffer> .. <Plug>(unite_delete_backward_path)
  nmap <buffer><BS> <Plug>(unite_delete_backward_path)

  let current = unite#get_current_unite()
  if current.buffer_name =~# '^search'
    nnoremap <silent><buffer><expr> r unite#do_action('replace')
  endif

  nnoremap <silent><buffer><expr> wh unite#smart_map('wh', unite#do_action('left'))
  inoremap <silent><buffer><expr> wh unite#smart_map('wh', unite#do_action('left'))
  nnoremap <silent><buffer><expr> wl unite#smart_map('wl', unite#do_action('right'))
  inoremap <silent><buffer><expr> wl unite#smart_map('wl', unite#do_action('right'))
  nnoremap <silent><buffer><expr> wk unite#smart_map('wk', unite#do_action('above'))
  inoremap <silent><buffer><expr> wk unite#smart_map('wk', unite#do_action('above'))
  nnoremap <silent><buffer><expr> wj unite#smart_map('wj', unite#do_action('below'))
  inoremap <silent><buffer><expr> wj unite#smart_map('wj', unite#do_action('below'))
endfunction " }}}

function! s:unite_project(...) " {{{
  let opts = (a:0 ? join(a:000, ' ') : '')
  let dir = unite#util#path2project_directory(expand('%'))
  execute 'UniteWithBufferDir' opts 'buffer file_rec:' . dir
endfunction " }}}

" unite-outline {{{
nnoremap <silent> <SID>[unite][ :<C-u>Unite outline -buffer-name=outline -vertical -winwidth=40<CR>
nnoremap <silent> <SID>[unite]{ :<C-u>Unite outline -no-quit -vertical -winwidth=40 -buffer-name=outline<CR>
" }}}
" unite-history {{{
nnoremap <silent> <SID>[unite]: :<C-u>Unite history/command -start-insert<CR>
" }}}
" unite-qf {{{
nnoremap <silent> <SID>[unite]q :<C-u>Unite qf -no-empty -no-start-insert -auto-preview<CR>
" }}}
" unite-colorscheme {{{
nnoremap <silent> <SID>[unite]\c :<C-u>Unite colorscheme -auto-preview<CR>
" }}}
" unite-fold {{{
nnoremap <silent> <SID>[unite]d :<C-u>Unite fold<CR>
" }}}
" }}}
" vim-powerline {{{
let g:Powerline_symbols = 'fancy'
let g:Powerline_mode_n = ' N '
" }}}
" vim-indent-guides {{{
let g:indent_guides_auto_colors           = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent  = 10

autocmd BufEnter * let g:indent_guides_guide_size = &sw
" }}}
" vim-altr {{{
nmap <Leader><C-[> <Plug>(altr-forward)
nmap <Leader><C-]> <Plug>(altr-back)

" Rails rules
call altr#define('app/models/%.rb', 'spec/models/%_spec.rb', 'spec/factories/%s.rb')
call altr#define('app/controllers/%.rb', 'spec/controllers/%_spec.rb')
call altr#define('app/helpers/%.rb', 'spec/helpers/%_spec.rb')
call altr#define('spec/routing/%_spec.rb', 'config/routes.rb')
" }}}
" foldCC {{{
set foldtext=FoldCCtext()
set foldcolumn=4
" }}}
" switch.vim {{{
nnoremap - :<C-u>Switch<CR>
" }}}
" }}}

" Colorscheme {{{
set bg=light
colorscheme solarized
" }}}
