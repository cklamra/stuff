call plug#begin()
Plug 'vimpostor/vim-lumen'
" autodarkmode mac/linux
Plug 'preservim/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'cklamra/vim-one'
Plug 'dense-analysis/ale'
"Plug 'prabirshrestha/vim-lsp'
Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'joshdick/onedark.vim'
"Plug 'sainnhe/everforest'
"Plug 'rakr/vim-one'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'chrisbra/csv.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'haya14busa/incsearch.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'chrisbra/Colorizer'
"if (has("nvim"))
"    Plug 'goolord/alpha-nvim'
"endif
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction
  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

if (has("nvim"))
    let vimdir = '$HOME/.local/share/nvim'
else
    let vimdir = '$HOME/.vim'
endif

syntax on
filetype plugin indent on
set number
set noswapfile
if has('persistent_undo')
  let myundodir = expand(vimdir . '/undo')
  call mkdir(myundodir, 'p')
  let &undodir = myundodir
  set undofile
endif
set smartindent
set ic
set mouse=a
set fillchars+=vert:\|
"set fillchars+=vert:│
hi VertSplit guibg=bg guifg=fg
let g:colorizer_auto_filetype='css,html,py,vim'

" Colors
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" >onedark
" colorscheme onedark


" >one
let g:one_allow_italics = 1 " for one
let g:airline_theme='one_transparent'
colorscheme one
set background=dark
au User LumenLight set background=light
au User LumenDark set background=dark

" airline symbols
let g:airline_powerline_fonts = 0
let g:airline_symbols = {}
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' '
let g:airline_symbols.linenr = ' '


" >everforest
"autocmd VimEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE
"let g:everforest_background='hard' " 'soft', 'medium', 'hard'
"let g:everforest_better_performance=1
"colorscheme everforest

" >onehalf
"au User LumenLight colorscheme onehalflight
"au User LumenLight let g:airline_theme='onehalflight'
"au User LumenDark colorscheme onehalfdark
"au User LumenDark let g:airline_theme='onehalfdark'"

"set colorcolumn=80
set expandtab
set showmatch
set encoding=utf-8

" window and tab switching
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <A-F1> 1gt
nnoremap <A-F2> 2gt
nnoremap <A-F3> 3gt
nnoremap <A-F4> 4gt
nnoremap <A-F5> 5gt
nnoremap <A-F6> 6gt
nnoremap <A-F7> 7gt
nnoremap <A-F8> 8gt
nnoremap <A-F9> 9gt
nnoremap <A-F10> 10gt

" F5 to execute python
autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>

" code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" search highlighting
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


" autocompletion, linging
let g:ale_linters = {'python': ['flake8', 'vulture']}
let g:ale_completion_enabled = 0
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_sign_error = '!'
let g:ale_sign_warning = '>'
let g:ale_sign_info = '~'
let g:ale_sign_style_error = '–'
let g:ale_sign_style_warning = '-'

" coc config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
autocmd CursorHold * silent call CocActionAsync('highlight')
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" NERDTree config
inoremap <c-b> <Esc>:NERDTreeToggle<cr>
nnoremap <c-b> <Esc>:NERDTreeToggle<cr>
hi def link NERDTreeExecFile ModeMsg
let NERDTreeIgnore=['\~$', '\.pyc$', '__pycache__']
"let g:nerdtree_tabs_open_on_console_startup=1
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree
"autocmd BufWinEnter * NERDTreeMirror
"autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
"autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
"autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
"nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>

" Which key
nnoremap <silent> <leader> :WhichKey '\'<CR>
set timeoutlen=500

call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlights': {
      \   'border': 'Normal',
      \ },
      \ 'border': 'rounded',
      \ })))

" TODO sessions, welcome screen

