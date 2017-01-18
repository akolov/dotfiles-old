"
" Alexander Kolov's vimrc
"
"

if &compatible
  set nocompatible
endif

filetype off

call plug#begin('~/.vim/plugged')
Plug 'jaxbot/semantic-highlight.vim'
Plug 'keith/swift.vim'
Plug 'landaire/deoplete-swift'
Plug 'milch/vim-fastlane'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
call plug#end()

filetype plugin indent on
syntax on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


let g:is_posix = 1

let g:airline#extensions#tabline#enabled = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

let g:mapleader="\<Space>"

" Create a directory if it doesn't exist yet
function! s:EnsureDirectory(directory)
  if !isdirectory(expand(a:directory))
    call mkdir(expand(a:directory), 'p')
  endif
endfunction

" I - Disable the startup message
" a - Avoid pressing enter after saves
set shortmess=Ia

set shell=$SHELL
set termencoding=utf-8
set encoding=utf-8
set autoindent                 " Indent the next line matching the previous line
set smartindent                " Smart auto-indent when creating a new line
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab                  " Insert spaces instead of actual tabs
set smarttab                   " Delete entire shiftwidth of tabs when they're inserted
set backspace=indent,eol,start
set nostartofline              " Keep cursor in the same place after saves
set noshowcmd                    " Show command information on the right side of the command line
set noshowmode
set noruler
set isfname-==                 " Remove characters from filenames for gf
set history=1000

" Set backup files
set backup
set backupdir=$HOME/.tmp/vim/backup
call s:EnsureDirectory(&backupdir)

" Write undo tree to a file to resume from next time the file is opened
if has('persistent_undo')
  set undolevels=2000            " The number of undo items to remember
  set undofile                   " Save undo history to files locally
  set undodir=$HOME/.vimundo     " Set the directory of the undofile
  call s:EnsureDirectory(&undodir)
endif

set directory=$HOME/.tmp/vim/swap
call s:EnsureDirectory(&directory)

" On quit reset title
let &titleold=getcwd()

set ttyfast                      " Set that we have a fast terminal
set t_Co=256                     " Explicitly tell Vim that the terminal supports 256 colors
set lazyredraw                   " Don't redraw vim in all situations
set synmaxcol=300                " The max number of columns to try and highlight
set noerrorbells                 " Don't make noise
set autoread                     " Watch for file changes and auto update
set showmatch      		           " Set show matching parenthesis
set matchtime=2         			   " The amount of time matches flash
set display=lastline        		 " Display super long wrapped lines<Paste>
set number             			     " Shows line numbers
set hidden                       " Hide buffers instead of closing them
set cursorline              		 " Highlight the line the cursor is on
set nrformats-=octal    		     " Never use octal notation
set nojoinspaces          		   " Don't add 2 spaces when using J
set mouse=a               		   " Enable using the mouse if terminal emulator
set mousehide              			 " Hide the mouse on typing
set hlsearch              	 	   " Highlight search terms
set incsearch        				     " Show searches as you type
set wrap             			       " Softwrap text
set linebreak             			 " Don't wrap in the middle of words
set ignorecase        		       " Ignore case when searching
set smartcase            			   " Ignore case if search is lowercase, otherwise case-sensitive
set title           		         " Change the terminal's title
set updatetime=2000      			   " Set the time before plugins assume you're not typing
set scrolloff=5			             " Lines the cursor is to the edge before scrolling
set sidescrolloff=5 			       " Same as scrolloff but horizontal
set gdefault              			 " Adds g at the end of substitutions by default
set virtualedit=block			       " Allow the cursor to move off the side in visual block
set foldlevelstart=99  			     " Set the default level of open folds
set foldmethod=indent   			   " Decide where to fold based
set foldnestmax=5  			         " Set deepest fold to x levels
set exrc    		                 " Source local .vimrc files
set secure       			           " Don't load autocmds from local .vimrc files
set tags^=.tags       		       " Add local .tags file

" Make |:find| discover recursive paths
set path+=**

" Completion options
set complete=.,w,b,u,t,i,kspell
set completeopt=menu
set wildmenu                                           " Better completion in the CLI
set wildmode=longest:full,full                         " Completion settings

" Ignore these folders for completions
set wildignore+=.hg,.git,.svn                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg         " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc " compiled object files
set wildignore+=tags,.tags

" Dictionary for custom words
set dictionary+=/usr/share/dict/words
set spellfile=$HOME/.vim/custom-words.utf-8.add

" Set mapping and key timeouts
set timeout
set timeoutlen=1000
set ttimeoutlen=100

" Setting to indent wrapped lines
if exists('+breakindent')
  set breakindent
  set breakindentopt=shift:2
endif

" Check for file specific vim settings in the last 3 lines of the file
set modeline
set modelines=2

if has('clipboard')     " If the feature is available
  set clipboard=unnamed " copy to the system clipboard

  if has('unnamedplus')
    set clipboard+=unnamedplus
  endif
endif

:nnoremap <Leader>s :SemanticHighlightToggle<cr>


" Jump to the first placeholder by typing `<C-j>`.
autocmd FileType swift imap <buffer> <C-j> <Plug>(deoplete_swift_jump_to_placeholder)

