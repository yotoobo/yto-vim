" 此vimrc是在<spf13>的基础上进行修改的.
" 为什么不直接用<spf13>?
" 因为它实在太强大了,有许多功能我都没有用到.
" 所以,只好弄了份简易版.
" 我主要是用来写shell和python的,所以如果你需要其他的支持,请去找<spf13>吧!
" 


" Environment {

    " Identify platform {
        silent function! OSX()
          return has('macunix')
        endfunction
        silent function! LINUX()
          return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
          return  (has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
          set shell=/bin/sh
        endif
    " }

    " windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
" Use before.local config {
    if filereadable(expand("~/.vimrc.before.local"))
      source ~/.vimrc.before.local
    endif
" }

" Use bundles config {
    if filereadable(expand("~/.vimrc.bundles"))
      source ~/.vimrc.bundles
    endif
" }

" General {

    filetype plugin indent on	" Automatically detect file types
    syntax on

    set mouse=a    " Automatically enable mouse usage
    set mousehide  " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
      if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
      else
        set clipboard=unnamed
      endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the
    " following to your .vimrc.before.local file:
    " let g:spf13_no_autochdir = 1
    if !exists('g:spf13_no_autochdir')
      autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
      " Always switch to the current file directory
    endif

    set history=1000
    set viewoptions=folds,options,cursor,unix,slash
    set virtualedit=onemore
    set spell
    set hidden
    set noswapfile
    set iskeyword-=.
    set iskeyword-=#
    set iskeyword-=-

    " Set backup
    set backup
    set backupext=.bak
    set backupdir=~/.vim/vimbak
    if has('persistent_undo')
      set undofile
      set undolevels=1000
      set undoreload=1000
    endif

" }


" Vim UI {
    
    if !has('gui_running')
      set background=dark
      set t_Co=256
    else
      set background=light
      " 禁止显示滚动条
      set guioptions-=l
      set guioptions-=L
      set guioptions-=r
      set guioptions-=R
      " 禁止显示菜单和工具条
      set guioptions-=m
      set guioptions-=T
    endif
    
    " 禁止光标闪烁
    set gcr=a:block-blinkon0
    

    if !exists('g:oerride_spf13_bundles') && filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        color solarized    " Load a colorscheme
    endif

    set tabpagemax=10
    set showmode

    set cursorline

    highlight clear SignColumn
    highlight clear LineNr
    
    if has('cmdline_info')
      set ruler
      set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
      set showcmd
    endif

    set backspace=indent,eol,start
    set linespace=0
    set number
    set showmatch
    set incsearch
    set nohlsearch
    set ignorecase
    set winminheight=0
    
" }


" Formatting {
    
    " normal
    set nowrap
    set autoindent
    set expandtab
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set nojoinspaces
    set splitright
    set splitbelow

    " for python
    let python_highlight_all = 1
    au FileType python set tabstop=4 
    au FileType python set softtabstop=4 
    au FileType python set shiftwidth=4
    au FileType python set textwidth=79
    au FileType python set expandtab
    au FileType python set autoindent

" }


" Key Mappings {

    let mapleader = ','

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " The easy way to moving in inoremap
    inoremap <c-k> <up>
    inoremap <c-j> <down>
    inoremap <c-h> <left>
    inoremap <c-l> <right>

    map <leader>w :w<CR>
    map <leader>x :x<CR>
    map <leader>q :q<CR>
    map <leader>qq :q!<CR>
    map! jk <esc>

" Plugins {

  " NerdTree {
    if isdirectory(expand("~/.vim/bundle/nerdtree"))
      map <F2> :NERDTreeToggle<CR>
      map <C-e> <plug>NERDTreeTabsToggle<CR>
      map <leader>e :NERDTreeFind<CR>
      nmap <leader>nt :NERDTreeFind<CR>

      let NERDTreeShowBookmarks=1
      let NERDTreeIgnore=['\.py[cd]$','\~$','\.swo$','\.swp$','^\.git$','^\.hg$','^\.svn$','\.bzr$']
      let NERDTreeChDirMode=0
      let NERDTreeQuitOnOpen=1
      let NERDTreeMouseMode=2
      let NERDTreeShowHidden=1
      let NERDTreeKeepTreeInNewTab=1
      let g:nerdtree_tabs_open_on_gui_startup=0
    endif
  " }
