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
      if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
      else  " On mac and Windows, use * register for copy-paste
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

    set encoding=utf-8
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

    set t_ti= t_te=  " 退出后显示文件内容

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
    set cursorcolumn

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
    
    " 分割窗口
    set splitbelow
    set splitright

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

    " 创建新文件自动添加标题 
    autocmd BufNewfile *.sh,*.py,*.php,*.rb,*.pl exec ":call SetTitle()"
    function SetTitle()
      if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."),"")
    
      elseif &filetype == 'python'
        call setline(1,"\#!/usr/bin/env python")
        call append(line("."),"# -*- coding: utf-8 -*-")
        call append(line(".")+1,"")
      
      elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
    
      elseif &filetype == 'php'
        call setline(1,"\<?php")
        call append(line("."),"")
        call append(line(".")+1,"\?>")
    
      elseif &filetype == 'pl'
        call setline(1,"\#!/usr/bin/perl")
        call append(line("."),"")
        call append(line(".")+1,"\?>")
    
      else
        call setline(1,"")
           
    endif
    
    endfunction
    autocmd BufNewfile * normal G "自动定位到新文件末行

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

    "split navigations
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-l> <c-w>l
    nnoremap <c-h> <c-w>h
    
    " 大小写转换
    nnoremap <c-u> bgUee
    inoremap <c-u> <esc>bgUeea

    " tab
    nnoremap <c-t> :tabnew<CR>
    inoremap <C-t> <Esc>:tabnew<CR>
    noremap <leader>1 1gt
    noremap <leader>2 2gt
    noremap <leader>3 3gt
    noremap <leader>4 4gt
    noremap <leader>5 5gt
    noremap <leader>6 6gt
    noremap <leader>7 7gt
    noremap <leader>8 8gt
    noremap <leader>9 9gt
    noremap <leader>0 :tablast<cr>
    let g:last_active_tab = 1
    nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
    vnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
    "autocmd TabLeave * let g:last_active_tab = tabpagenr()

    " <F3> 打开/关闭行号
    function! HideNumber()
      if(&relativenumber == &number)
        set relativenumber! number!
      elseif(&number)
        set number!
      else
        set relativenumber!
      endif
      set number?
    endfunc
    nnoremap <F3> :call HideNumber()<CR>

    map <F5> :w<cr>:!python %<cr>

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
