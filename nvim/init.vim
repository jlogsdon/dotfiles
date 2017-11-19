" vim: foldmethod=marker foldmarker={,}

set shell=zsh
set enc=utf-8
set noexrc

" Remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Plugins {
  if &compatible
    set nocompatible
  endif

  set runtimepath^=/home/jlogsdon/.cache/dein/repos/github.com/Shougo/dein.vim
  call dein#begin(expand('~/.cache/dein'))
  call dein#add('Shougo/dein.vim')

  call dein#add('airblade/vim-gitgutter')
  call dein#add('bling/vim-airline')
  call dein#add('cakebaker/scss-syntax.vim')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('godlygeek/tabular')
  call dein#add('hail2u/vim-css3-syntax')
  call dein#add('hashivim/vim-terraform')
  call dein#add('mileszs/ack.vim')
  call dein#add('myusuf3/numbers.vim')
  call dein#add('mxw/vim-jsx')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('neomake/neomake')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neopairs.vim')
  call dein#add('Shougo/Denite.nvim')
  call dein#add('Shougo/vimproc.vim')
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('joukevandermaas/vim-ember-hbs')
  call dein#add('AndrewRadev/ember_tools.vim')
  call dein#add('vimwiki/vimwiki')

  call dein#end()
  filetype plugin indent on
  syntax on

  if dein#check_install()
    call dein#install()
  endif
" }

" Interface {
  colorscheme Tomorrow-Night-Bright

  set background=dark
  set cursorcolumn
  set cursorline
  set incsearch
  "set hlsearch
  set laststatus=2
  set lazyredraw
  set linespace=0
  set list
  set listchars=tab:>-,trail:-
  set matchtime=0
  set nostartofline
  set novisualbell
  set numberwidth=5
  set number
  set report=0
  set ruler
  set scrolloff=10
  set sidescrolloff=10
  set shortmess=aOstT
  set showcmd
  set noshowmatch
  set splitbelow
  set splitright
  set wildmenu
  set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
  set wildmode=list:longest
  set wildignorecase
  set mouse=
  set nobackup
  set nowritebackup
" }

" Formatting {
  set expandtab
  set shiftround
  set shiftwidth=2
  set softtabstop=2
  set tabstop=8
  set ignorecase
  set infercase
  set nowrap
  set textwidth=100
  set foldmethod=marker
" }

" Mappings {
  nnoremap <up> <nop>
  nnoremap <down> <nop>
  nnoremap <left> <nop>
  nnoremap <right> <nop>
" }

" Misc Plugins {
  let g:ember_tools_extract_behaviour = 'component-dir'
  let g:vimwiki_folding = 'list'
  let g:jsx_ext_required = 0

  let g:ackprg = 'ag --vimgrep'
  nmap <M-k>  :Ack! "\b<cword>\b" <CR>
  nmap <Esc>k :Ack! "\b<cword>\b" <CR>
" }

" NERDTree {
  " Start with NERDTree open if no paths were provided
  autocmd vimenter * if !argc() | NERDTree | endif
  map <C-n> :NERDTreeToggle<CR>
" }

" Denite {
  call denite#custom#var("file_rec", "command",
    \ [ "find", "-L", ":directory",
    \ "-path", "*/.git/*", "-prune", "-o",
    \ "-path", "*/vendor/*", "-prune", "-o",
    \ "-path", "*/node_modules/*", "-prune", "-o",
    \ "-path", "*/bower_components/*", "-prune", "-o",
    \ "-type", "l", "-print", "-o",
    \ "-type", "f", "-print"])

  call denite#custom#source(
    \ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

  nnoremap <leader>fe :Denite file_rec -default-action=open<CR>
  nnoremap <leader>ft :Denite file_rec -default-action=tabopen<CR>
  nnoremap <leader>fv :Denite file_rec -default-action=vsplit<CR>
  nnoremap <leader>fs :Denite file_rec -default-action=split<CR>
" }

" NeoMake {
  autocmd BufRead,BufWritePost * Neomake
  autocmd BufUnload,BufWinLeave * lclose
  autocmd FileType javascript :call NeomakeESlintChecker()

  nnoremap <leader>st :NeomakeToggle<CR>
  nnoremap <leader>sc :Neomake<CR>
  let g:neomake_open_list = 2
  let g:neomake_list_height = 5
  let g:neomake_ruby_enabled_makers = ['rubocop']
  let g:neomake_javascript_enabled_makers = ['eslint']
  "let g:neomake_logfile = expand('~/.cache/neomake.log')

  function! NeomakeESlintChecker()
    let l:npm_bin = ''
    let l:eslint = 'eslint'

    if executable('npm-which')
      let l:eslint = split(system('npm-which eslint'))[0]
    endif

    if executable('npm')
      let l:npm_bin = split(system('npm bin'), '\n')[0]
    endif

    if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
      let l:eslint = l:npm_bin . '/eslint'
    endif

    let b:neomake_javascript_eslint_exe = l:eslint
  endfunction
" }

" RuboCop Setup {
  " Shamelessly cribbed from https://github.com/ngmy/vim-rubocop/blob/master/plugin/rubocop.vim
  function RuboCorrect()
    let l:filename     = @%
    let l:rubocop_cmd  = 'rubocop'
    let l:rubocop_opts = ' --auto-correct --format emacs'

    let l:rubocop_output = system(l:rubocop_cmd.l:rubocop_opts.' '.l:filename)
    " Reload after it runs
    edit
  endfunction

  map <silent> <leader>ra :call RuboCorrect()<CR>
" }
