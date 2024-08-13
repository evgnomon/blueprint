set nocompatible              
set exrc
set secure
set encoding=utf-8
set autowrite " writes in case of :make (used in go)
set ic " case insensitive search
set mouse=a
" set textwidth=79
filetype on
filetype plugin indent on
filetype plugin on
set signcolumn=yes
set scrolloff=0
set noswapfile
set nowritebackup
set nobackup
set number
set cursorline
set ttyfast
syntax on
set tabstop=2
set shiftwidth=2
set smarttab
set autoindent
set expandtab
set exrc
nmap <F10> :on<CR>
set incsearch
set hlsearch
let mapleader=","

:set showmatch
:set number relativenumber
:let python_highlight_all = 1
:set backspace=indent,eol,start
set background=dark

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

if has('win32')
    set clipboard=unnamed
elseif has('mac')
    set clipboard=unnamed
elseif has('unix')
    set clipboard=unnamedplus
endif

set guifont=Inconsolata\ Nerd\ Font:h15
" let g:Powerline_symbols = 'fancy'
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set completeopt=preview,menuone,popup

" Plugins
call plug#begin('~/.vim/plugged')

" Colors
Plug 'flazz/vim-colorschemes'

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mcchrish/nnn.vim'

" Snippet
Plug 'SirVer/ultisnips'

" Formatter
Plug 'tpope/vim-commentary'
Plug 'https://github.com/rhysd/vim-clang-format'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Github
Plug 'ruanyl/vim-gh-line'

" Terraform
Plug 'hashivim/vim-terraform'

" Python
" Plug 'mgedmin/python-imports.vim'

" JS/TS
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}

" Auto Completion / LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'

call plug#end()

nmap <silent> <leader>kk ?function<cr>:noh<cr><Plug>(jsdoc)

" Must be after laoding plugins
colorscheme PaperColor

" Snippets
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = $HOME."/src/github.com/".$USER."/nuggets/ultisnips"
let g:UltiSnipsSnippetDirectories=[$HOME."/src/github.com/".$USER."/nuggets/ultisnips", "UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"                                            
let g:UltiSnipsJumpForwardTrigger="<tab>"                                       
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"                                    

" nnoremap <leader>o :CtrlPBuffer<CR>
nnoremap <C-J> :bnext<CR>
nnoremap <C-K> :bprev<CR>
nnoremap <C-P> :History<CR>
nnoremap <leader>o :Files<CR>

" Reformat
let g:black_linelength=79

autocmd FileType python,go,javascript,typescript,
\javascriptreact,typescriptreact,rust,sh                    nnoremap <C-l> <Plug>(coc-format)
autocmd FileType proto                                      noremap <C-l> :ClangFormat<CR>
autocmd FileType json,html                                  noremap <C-l> :Prettier<CR>
autocmd FileType toml                                       noremap <C-l> :Prettier<CR>
autocmd FileType terraform                                  noremap <C-l> :TerraformFmt<CR>

" Run Command
autocmd FileType rust                                       noremap <C-k><C-r> :CocCommand rust-analyzer.testCurrent<CR>

" Commands
map <C-A> :Commands<CR>
map <C-S-A> :CocCommand<CR>
map <leader>kp :echo @% <CR>

" Tags
map <leader>t :Tags<CR>
map <leader>f :Rg!<CR>
nmap <Leader>7 :BTags<CR>
nmap <S-F3> :CocList -I symbols<CR>

" References
" Copy Location to clipboard
:nmap <leader>8 :let @+ = join([expand('%'),  line(".")], ':')<cr>

" Copy/Paste
map <Leader>v "+p
map <Leader>c "+y
map ]l :cn<CR>

nmap <leader>i :CocCommand editor.action.organizeImport<CR>
nmap <leader>. <Plug>(coc-codeaction)

let g:loclist_follow = 1
let g:tex_flavor = 'pdflatex'

let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0
let g:gh_line_map = '<leader>kg'
let g:gh_line_blame_map = '<leader>kb'
let g:gh_repo_map = '<leader>kr'

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let g:go_fmt_command="gopls"
let g:go_gopls_gofumpt=1

:command! CopyPath let @+ = expand('%:p')

" GoTo code navigation
nmap <silent> <leader>g <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <leader>3 <Plug>(coc-references)
" nmap <silent> gr <Plug>(coc-references)

nmap <silent> <F2> <Plug>(coc-diagnostic-next)
noremap <silent> <S-F2> <Plug>(coc-diagnostic-prev)

" Use K to show documentation in preview window
nnoremap <leader>q :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

inoremap <silent><expr> <c-@> coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <S-F6> <Plug>(coc-rename)


" Remap <C-f> and <C-b> to scroll float windows/popups
if has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

function! ToggleFile()
  if bufname("%") == ""
    execute ":NnnPicker"
  else
    execute ":NnnPicker %:p"
  endif
endfunction

nnoremap <leader>x :call ToggleFile()<CR>
