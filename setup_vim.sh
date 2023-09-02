curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if ! [ -x "$(command -v node)" ]; then
  curl -sL install-node.vercel.app/lts | bash
fi
python3 -m pip install flake8

echo "
call plug#begin()
\"Plug 'vimpostor/vim-lumen'
\" autodarkmode mac/linux
Plug 'preservim/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-airline/vim-airline'
\"Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
\"Plug 'prabirshrestha/vim-lsp'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'joshdick/onedark.vim'
\"Plug 'sainnhe/everforest'
\"Plug 'rakr/vim-one'
\"Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'chrisbra/csv.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'haya14busa/incsearch.vim'
call plug#end()

syntax on
filetype plugin indent on
set number
set noswapfile
set undodir=~/.vim/undo
set undofile
set smartindent
set ic
set mouse=a

if has('persistent_undo')
  set undodir=$HOME/.vim/undo
  set undofile
endif

\"if has('termguicolors')
\"  set termguicolors
\"endif

\"au User LumenLight colorscheme onehalflight
\"au User LumenLight let g:airline_theme='onehalflight'
\"au User LumenDark colorscheme onehalfdark
\"au User LumenDark let g:airline_theme='onehalfdark'
colorscheme onedark
\"autocmd VimEnter * hi EndOfBuffer guibg=NONE ctermbg=NONE
\"let g:everforest_background='hard' \" 'soft', 'medium', 'hard'
\"let g:everforest_better_performance=1
\"colorscheme everforest
\"colorscheme one

\"set colorcolumn=80
set expandtab
set showmatch
set encoding=utf-8

\" window and tab switching
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

\" airline symbols
\"let g:airline_powerline_fonts = 1
let g:airline_symbols = {}
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' '
let g:airline_symbols.linenr = ' '

\" F5 to execute python
autocmd FileType python nnoremap <buffer> <F5> :w<cr>:exec '!clear'<cr>:exec '!python3' shellescape(expand('%:p'), 1)<cr>

\" code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

\" search highlighting
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


\" autocompletion, linging
let g:ale_linters = {'python': ['flake8', 'vulture']}
let g:ale_completion_enabled = 0
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_sign_error = '!'
let g:ale_sign_warning = '>'
let g:ale_sign_info = '~'
let g:ale_sign_style_error = '–'
let g:ale_sign_style_warning = '-'

\" coc config
inoremap <silent><expr> <TAB>
      \\ coc#pum#visible() ? coc#pum#next(1) :
      \\ CheckBackspace() ? \"<Tab>\" :
      \\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : \"\<C-h>\"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \\: \"\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\<CR>\"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
autocmd CursorHold * silent call CocActionAsync('highlight')
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\\s'
endfunction

\" NERDTree config
inoremap <c-b> <Esc>:NERDTreeToggle<cr>
nnoremap <c-b> <Esc>:NERDTreeToggle<cr>
let NERDTreeIgnore=['\\~$', '\\.pyc$', '__pycache__']
let g:nerdtree_tabs_open_on_console_startup=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists(\"s:std_in\") | wincmd p | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
\"autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
\"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\\d\\+' && bufname('%') !~ 'NERD_tree_\\d\\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute \"normal! \\<C-W>w\" | execute 'buffer'.buf | endif
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
\" TODO sessions, welcome screen
" > ~/.vimrc

vim -c "PlugInstall | qa"
vim -c "CocInstall coc-pyright | qa"
vim -c "CocInstall coc-json | qa"

echo "{
    \"pyright.inlayHints.functionReturnTypes\": false,
    \"pyright.inlayHints.variableTypes\": false,
    \"python.linting.enabled\": false
}" > ~/.vim/coc-settings.json
