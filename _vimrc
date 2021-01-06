" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
    Plug 'mhinz/vim-startify'
    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/nerdtree'
    Plug 'vim-scripts/bufexplorer.zip'
    Plug 'kien/ctrlp.vim'
    Plug 'scrooloose/nerdcommenter'
    Plug 'majutsushi/tagbar'
    Plug 'scrooloose/syntastic'
    Plug 'easymotion/vim-easymotion'
    Plug 'dyng/ctrlsf.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'yonchu/accelerated-smooth-scroll'
    Plug 'vim-scripts/Mark--Karkat'
    Plug 'vim-scripts/sessionman.vim'
    Plug 'klen/python-mode'
    Plug 'tacahiroy/ctrlp-funky'
    Plug 'suan/vim-instant-markdown'
    Plug 'plasticboy/vim-markdown'
    Plug 'altercation/vim-colors-solarized'
    Plug 'Yggdroot/indentLine'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()


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

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath+=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
" }

" General {
    colorscheme solarized
    "set background=dark        " Assume a light background

    " Allow to trigger background
    function! ToggleBG()
        let s:tbg = &background
        " Inversion
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif 
    endif 

    " Most prefer:to automatically switch to the current file directory when
    " a new buffer is opened;
    " autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END

    " Setting up the directories {
    "    set nobackup                  " Backups are nice ...
    "    if has('persistent_undo')
    "        set undofile                " So is persistent undo ...
    "        set undolevels=1000         " Maximum number of changes that can be undone
    "        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    "    endif

    " }
" }

" Vim UI {
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline "cursorcolumn                 " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        "set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set relativenumber              " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    "set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=2                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set foldmethod=manual            " fold method
    "set list
    set listchars=tab:\|\ ,extends:#,nbsp:. " Highlight problematic whitespace
" }

" Formatting {
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use ikndents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> | call StripTrailingWhitespace()
" }

" Key (re)Mappings {
    " The default leader is '\', but many people prefer ','
    let mapleader = ','

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add the following to your
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " The following two lines conflict with moving to top and
    " bottom of the screen
    "map <S-H> gT
    "map <S-L> gt


    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip
" }

" Plugins {
    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }



    " NerdTree {
        if isdirectory(expand("~/.vim/plugged/nerdtree"))
            map <C-e> <plug>NERDTreeTabsToggle<CR>
            nmap <leader>nt :NERDTree<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }

    " PyMode {
        " Disable if python support not present
        if !has('python') && !has('python3')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/plugged/python-mode"))
            let g:pymode_lint_checkers = ['pyflakes']
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0
            let g:pymode_folding = 0
        endif
    " }

    " ctrlp {
        if isdirectory(expand("~/.vim/plugged/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <leader>fb :CtrlPBuffer<CR>
            nnoremap <silent> <leader>fm :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            " On Windows use "dir" as fallback command.
            elseif WINDOWS()
                let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            if isdirectory(expand("~/.vim/plugged/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']
                "let g:ctrlp_funky_matchtype = 'path'
                let g:ctrlp_funky_syntax_highlight = 1
                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
                " narrow the list down with a word under cursor
                nnoremap <Leader>fk :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
            endif
        endif
    "}

    " TagBar {
        if isdirectory(expand("~/.vim/plugged/tagbar/"))
            nnoremap <silent> <leader>tt :TagbarToggle<CR>
        endif
    "}

    " indent_guides {
        if isdirectory(expand("~/.vim/plugged/vim-indent-guides/"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
        endif
    " }
" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        "set guioptions-=T           " Remove the toolbar
        "set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if LINUX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 12,Consolas\ Regular\ 12,Courier\ New\ Regular\ 12
        elseif OSX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
        elseif WINDOWS() && has("gui_running")
            set guifont=Andale_Mono:h12,Menlo:h12,Consolas:h12,Courier_New:h12
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif
" }

" Functions {
    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        if exists('g:spf13_consolidated_directory')
            let common_dir = g:spf13_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
    " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }
" }





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"自己的配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set lines=40                " 40 lines of text instead of 24
else
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi       " Make arrow and other keys work
endif

"mapleader
let mapleader = ","

":set showtabline=1 
":set tabline=%n\ %f\ %m
:set gtl=%n\ %f\ %m
:ca ws lcd ~/workspace
:ca q close
:cd F:\tmp_dir

cmap w!! w !sudo tee > /dev/null %

"set rnu
set nospell
set report=0
"set nofoldenable
set title


set visualbell t_vb=

"Favorite filetypes
set ffs=unix,dos
"nmap <leader>fd :se ff=dos<cr>
"nmap <leader>fu :se ff=unix<cr>

"open current file in sourceinsight
nmap <silent> <leader>si :update<CR>:silent !start "D:\Program Files (x86)\Source Insight 4.0\sourceinsight4.exe" -i +<C-R>=expand(line("."))<CR> %<CR>

"open file in explorer
if WINDOWS()
    function! MyOpenFileLocation() 
        if ( expand("%") != "" ) 
            execute "!start explorer /select, %" 
        else 
            execute "!start explorer /select, %: p : h" 
        endif 
    endfunction
else
    function! MyOpenFileLocation() 
        if ( expand("%") != "" ) 
            execute "!nemo %" 
        else 
            execute "!nemo %: p : h" 
        endif 
    endfunction
endif
map <leader>dir <ESC>:call MyOpenFileLocation()<CR> 



"Set to auto read when a file is changed from the outside
set autoread


"Fast remove highlight search
nmap <silent> <leader><cr> :noh<cr>

"Fast redraw
"nmap <silent> <leader>r:redraw!<cr>


" Chinese
if WINDOWS()
   set encoding=utf-8
   set langmenu=zh_CN.UTF-8
   language message zh_CN.UTF-8
   set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1,chinese
endif

" Set helplang
set helplang=cn

"Fast reloading of the .vimrc
map <silent> <leader>s :source ~/_vimrc<cr>

"Fast editing of .vimrc
map <silent> <leader>e :tabnew ~/_vimrc<cr>

"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/_vimrc


"解决菜单栏乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"source $VIMRUNTIME/mswin.vim
"vim提示信息乱码的解决
language messages zh_CN.utf-8
behave mswin


""""""""""""""""""""""""""""""
   " Tagbar 
""""""""""""""""""""""""""""""
map <silent> <leader>tb :Tagbar<CR>

""""""""""""""""""""""""""""""
   " BufExplorer 
""""""""""""""""""""""""""""""
map <silent> <leader>be :BufExplorer<CR>

