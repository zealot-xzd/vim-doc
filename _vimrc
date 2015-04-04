"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This vimrc is based on the vimrc by Amix, URL:

"         http://www.amix.dk/vim/vimrc.html

" Maintainer: Easwy

" Version: 0.1

" Last Change: 31/05/07 09:17:57 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

 
":cd f:\document
au BufRead,BufNewFile,BufEnter * cd %:p:h
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Get out of VI's compatible mode..

set nocompatible

 

" Platform

function! MySys()

  return "windows"

endfunction

 

"Sets how many lines of history VIM har to remember

set history=400

 

" Chinese

if MySys() == "windows"

   set encoding=utf-8

   set langmenu=zh_CN.UTF-8

   language message zh_CN.UTF-8

   set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1

endif

 

"Enable filetype plugin

filetype plugin on

filetype indent on

 

"Set to auto read when a file is changed from the outside

set autoread

 

"Have the mouse enabled all the time:

set mouse=a

 

"Set mapleader

let mapleader = ","

let g:mapleader = ","

 

"Fast saving

nmap <silent> <leader>ww :w<cr>

nmap <silent> <leader>wf :w!<cr>

 

"Fast quiting

nmap <silent> <leader>qw :wq<cr>

nmap <silent> <leader>qf :q!<cr>

nmap <silent> <leader>qq :q<cr>

nmap <silent> <leader>qa :qa<cr>

 

"Fast remove highlight search

nmap <silent> <leader><cr> :noh<cr>

 

"Fast redraw

nmap <silent> <leader>rr :redraw!<cr>

 

" Switch to buffer according to file name

function! SwitchToBuf(filename)

    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")

    " find in current tab

    let bufwinnr = bufwinnr(a:filename)

    if bufwinnr != -1

        exec bufwinnr . "wincmd w"

        return

    else

        " find in each tab

        tabfirst

        let tab = 1

        while tab <= tabpagenr("$")

            let bufwinnr = bufwinnr(a:filename)

            if bufwinnr != -1

                exec "normal " . tab . "gt"

                exec bufwinnr . "wincmd w"

                return

            endif

            tabnext

            let tab = tab + 1

        endwhile

        " not exist, new tab

        exec "tabnew " . a:filename

    endif

endfunction

 

"Fast edit vimrc

if MySys() == 'linux'

    "Fast reloading of the .vimrc

    map <silent> <leader>ss :source ~/.vimrc<cr>

    "Fast editing of .vimrc

    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>

    "When .vimrc is edited, reload it

    autocmd! bufwritepost .vimrc source ~/.vimrc

elseif MySys() == 'windows'

    " Set helplang

    set helplang=cn

    "Fast reloading of the _vimrc

    map <silent> <leader>ss :source ~/_vimrc<cr>

    "Fast editing of _vimrc

    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>

    "When _vimrc is edited, reload it

    autocmd! bufwritepost _vimrc source ~/_vimrc

endif

 

" For windows version

if MySys() == 'windows'

    source $VIMRUNTIME/mswin.vim

    behave mswin

 

    set diffexpr=MyDiff()

    function! MyDiff()

        let opt = '-a --binary '

        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif

        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif

        let arg1 = v:fname_in

        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif

        let arg2 = v:fname_new

        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif

        let arg3 = v:fname_out

        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif

        let eq = ''

        if $VIMRUNTIME =~ ' '

            if &sh =~ '\<cmd'

                let cmd = '""' . $VIMRUNTIME . '\diff"'

                let eq = '"'

            else

                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'

            endif

        else

            let cmd = $VIMRUNTIME . '\diff'

        endif

        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq

    endfunction

endif

 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Colors and Fonts

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

 

"Set font

"if MySys() == "linux"

"  set gfn=Monospace\ 11

"endif

 

" Avoid clearing hilight definition in plugins

if !exists("g:vimrc_loaded")

    "Enable syntax hl

    syntax enable

 

    " color scheme

    if has("gui_running")

        set guioptions-=T

"        set guioptions-=m

        set guioptions-=L

        set guioptions-=r

"        colorscheme darkblue_my

        "hi normal guibg=#294d4a

    else

        colorscheme desert_my

    endif " has

endif " exists(...)

 

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)

map <leader>$ :syntax sync fromstart<cr>

 

autocmd BufEnter * :syntax sync fromstart

 

"Highlight current

"if has("gui_running")

"""  set cursorline
 """ set background=light

  ""hi cursorline guibg=#333333

"""  hi CursorColumn guibg=#333333

"endif

 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fileformats

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Favorite filetypes

set ffs=unix,dos

 

nmap <leader>fd :se ff=dos<cr>

nmap <leader>fu :se ff=unix<cr>

 
   """"""""""""""""""""""""""""""
   " mark setting
   """"""""""""""""""""""""""""""
   nmap <silent> <leader>hl <Plug>MarkSet
   vmap <silent> <leader>hl <Plug>MarkSet
   nmap <silent> <leader>hh <Plug>MarkClear
   vmap <silent> <leader>hh <Plug>MarkClear
   nmap <silent> <leader>hr <Plug>MarkRegex
   vmap <silent> <leader>hr <Plug>MarkRegex
 
syntax enable
set background=dark
colorscheme solarized
 
if has('gui_running')
	set background=light
else
	set background=dark
endif

:nmap ,f :update<CR>:silent !start c:\\progra~1\\intern~1\\explore.exe file://%:p
