" vim: foldmethod=marker foldmarker={,} spell:

set shell=zsh
set enc=utf-8
set noexrc

syntax on
colorscheme Tomorrow-Night-Bright

" Remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Packages {
  set runtimepath^=/Users/jlogsdon/.cache/dein/repos/github.com/Shougo/dein.vim
  call dein#begin(expand('/Users/jlogsdon/.cache/dein'))

  call dein#add('Shougo/dein.vim')

  call dein#add('airblade/vim-gitgutter')
  call dein#add('bling/vim-airline')
  call dein#add('cakebaker/scss-syntax.vim')
  call dein#add('ervandew/supertab')
  call dein#add('godlygeek/tabular')
  call dein#add('hail2u/vim-css3-syntax')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('lambdatoast/elm.vim')
  call dein#add('myusuf3/numbers.vim')
  call dein#add('mxw/vim-jsx')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('Quramy/tsuquyomi')
  call dein#add('rizzatti/dash.vim')
  call dein#add('rking/ag.vim')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neopairs.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimproc.vim')
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tmux-plugins/vim-tmux')
  call dein#add('tmux-plugins/vim-tmux-focus-events')

  call dein#end()
  filetype plugin indent on

  if dein#check_install()
    call dein#install()
  endif
" }

" Package settings {
  let g:vimfiler_as_default_explorer = 1
  let g:deoplete#enable_at_startup = 1
  let g:jsx_ext_required = 1

  let g:airline_powerline_fonts = 1

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['eslint']

  autocmd vimenter * if !argc() | NERDTree | endif
  map <C-n> :NERDTreeToggle<CR>

  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  nnoremap <leader>ft :Unite -start-insert file_rec/async -default-action=tabopen<CR>
  nnoremap <leader>fs :Unite -start-insert file_rec/async -default-action=split<CR>
  nnoremap <leader>fv :Unite -start-insert file_rec/async -default-action=vsplit<CR>
  nnoremap <leader>fc :Unite -start-insert file_rec/async<CR>
  nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
  nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

  " Custom mappings for the unite buffer
  autocmd FileType unite call s:unite_settings()
  function! s:unite_settings()
    " Play nice with supertab
    let b:SuperTabDisabled=1
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  endfunction

  nmap <silent> <leader>d <Plug>DashSearch
" }

" Vim UI {
    set background=dark
    set cursorcolumn " highlight the current column
    set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you
                   " search phrase
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines
                     " betweens rows
    set list " we do what to show tabs, to ensure we get them
              " out of my files
    set listchars=tab:>-,trail:- " show tabs and trailing
    set matchtime=0 " how many tenths of a second to blink
                     " matching brackets for
    set nohlsearch " do not highlight searched for phrases
    set nostartofline " leave my cursor where it was
    set novisualbell " don't blink
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid
                         " 'press a key' prompt
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    set number
    set sidescrolloff=10 " Keep 5 lines at the size
    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current
    "              | | | | |  |   |      |  |     |       column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in
    "              | | | | |  |   |          square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
    set wmh=0 " Set the minimum window height to 0 (hides split panes)
    set splitbelow
    set splitright

    set wildmenu " turn on command line completion wild style
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
                    \*.jpg,*.gif,*.png
    set wildmode=list:longest " turn on wild mode huge list
    set wildignorecase
" }

" Text Formatting/Layout {
    set expandtab " no real tabs please!
    set ignorecase " case insensitive by default
    set infercase " case inferred by default
    set nowrap " do not wrap line
    set textwidth=100
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase " if there are caps, go case-sensitive
    set shiftwidth=2 " auto-indent amount when using cindent,
                      " >>, << and stuff like that
    set softtabstop=2 " when hitting tab or backspace, how many spaces
                       "should a tab be (see expandtab)
    set tabstop=8 " real tabs should be 8, and they will show with
                   " set list on
" }

" Folding {
    set foldenable " Turn on folding
    set foldmarker={,} " Fold C style code (only use this as default
                        " if you use a high foldlevel)
    set foldmethod=marker " Fold on the marker
    set foldlevel=100 " Don't autofold anything (but I can still
                      " fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements
                                                      " open folds
    function SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText() " Custom fold text function
                                   " (cleaner than default)
" }

" Mappings {
    " space / shift-space scroll in normal mode
    noremap <S-space> <C-b>
    noremap <space> <C-f>

    " open omnimenu
    imap <c-space> <c-x><c-o>

    " Use C-u to _move_ to the last undo point, but not perform the undo
    noremap <C-u> :GundoToggle<CR>

    nnoremap <up> <nop>
    nnoremap <down> <nop>
    nnoremap <left> <nop>
    nnoremap <right> <nop>

    " Make omnicomplete better
    inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
      \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
    inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
      \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }
