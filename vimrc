set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
 Plugin 'VundleVim/Vundle.vim'

 Plugin 'sheerun/vim-polyglot' 

 Plugin 'jmcantrell/vim-virtualenv'

 Plugin 'Valloric/YouCompleteMe'

 Plugin 'rking/ag.vim'
 
 Plugin 'ctrlpvim/ctrlp.vim'

 Plugin 'tomasr/molokai'

 Plugin 'nvie/vim-flake8'

 Plugin 'sjl/gundo.vim'
 
 " " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
"
" " All of your Plugins must be added before the following line
 call vundle#end()            " required
 filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

syntax enable

let g:solarized_termcolors=256

if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

"Spaces & Tabs {{{

set tabstop=4 "number of visual spaces per TAB
set softtabstop=4 "number of spaces in tab when editing
set expandtab "tabs are spaces

" }}}

"UI CONFIG {{{

set number " show line numbers
set showcmd "show the last command entered in the very bottom right of VIM
set cursorline "highlight current line

filetype indent on "loda filetype-specific indent files
"This both turns on filetype detection and allows loading of language specific
"indentation files based on that detection. For me, this means the python
"indentation file that lives at ~/.vim/indent/python.vim gets loaded every
"time I open a *.py file.

set wildmenu "visual autocomplete for command menu

set lazyredraw "redraw only when we need to

set showmatch " highlight matching [{()}]

" }}}

"SEARCHING {{{

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

"}}}

"FOLDING {{{

set foldenable          " enable folding

set foldlevelstart=10   " open most folds by default
"Folds can be nested. Setting a max on the number of folds guards against too
"many folds. If you need more than 10 fold levels you must be writing some
"Javascript burning in callback-hell and I feel very bad for you.

" space open/closes folds
nnoremap <space> za

set foldmethod=indent   " fold based on indent level
"This tells Vim to fold based on indentation. This is especially useful for me
"since I spend my days in Python. Other acceptable values are marker, manual,
"expr, syntax, diff. Run :help foldmethod to find out what each of those do.

" }}}

" MOVEMENT {{{

" move vertically by visual line
nnoremap j gj
nnoremap k gk
"These two allow us to move around lines visually. So if there's a very long
"line that gets visually wrapped to two lines, j won't skip over the "fake"
"part of the visual line in favor of the next "real" line.

" highlight last inserted text
nnoremap gV `[v`]
"This one is pretty cool. It visually selects the block of characters you
"added last time you were in INSERT mode. 

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
" }}} 


" SHORTCUTS {{{

" toggle gundo
 "nnoremap <leader>u :GundoToggle<CR>
nnoremap <F5> :GundoToggle<CR>
 "In one of its cleverest innovations, Vim doesn't model undo as a simple
 "stack. In Vim it's a tree. This makes sure you never lose an action in Vim,
 "but also makes it much more difficult to traverse around that tree.
 "gundo.vim fixes this by displaying that undo tree in graphical form. Get it
 "and don't look back. Here I've mapped it to ,u, which I like to think of as
 ""super undo".

" save session
nnoremap <leader>s :mksession<CR>
"Ever wanted to save a given assortment of windows so that they're there next
"time you open up Vim? :mksession does just that! After saving a Vim session,
"you can reopen it with vim -S. Here I've mapped it to ,s, which I remember by
"thinking of it as "super save".



" open ag.vim
nnoremap <leader>a :Ag
"The Silver Searcher is a fantastic command line tool to search source code in
"a project. It's wicked fast. The command line tool is named ag (like the
"element silver). Thankfully there is a wonderful Vim plugin ag.vim which lets
"you use ag without leaving Vim and pulls the results into a quickfix window
"for easily jumping to the matches. Here I've mapped it to ,a.

" }}}
" CtrlP settings {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" }}}


" AUTOGROUP {{{

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
augroup END

" }}}


" BACKUPS  {{{

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

"backup and writebackup enable backup support. As annoying as this can be, it
"is much better than losing tons of work in an edited-but-not-written file.

" }}}

let g:flake8_quickfix_location="topleft"

" PYTHON SPECIFIC {{{
"filetype plugin indent on
"au FileType py set autoindent
"au FileType py set smartindent
"au FileType py set textwidth=79 " PEP-8 Friendly

"}}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
