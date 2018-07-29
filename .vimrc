
set nocompatible              " be iMproved, required
set number
set cursorline
set colorcolumn=100
set runtimepath+=~/.vim_runtime
map ≥ :bn<cr>
map ≤ :bp<cr>
map ∂ :bd<cr>
map ß :w<cr>
map π :'a,'byank<cr>
autocmd Filetype ruby setlocal tabstop=2
autocmd Filetype ruby setlocal shiftwidth=2
autocmd Filetype ruby setlocal expandtab
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mhinz/vim-signify'
Plugin 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'css', 'json']
  \ }


source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim


try
source ~/.vim_runtime/my_configs.vim
catch
endtry


Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " used for completion for LanguageClient

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



" Prettier config:
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
let g:prettier#quickfix_enabled = 1

" max line length that prettier will wrap on
" Prettier default: 80
let g:prettier#config#print_width = 100

" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 4

" use tabs over spaces
" Prettier default: false
let g:prettier#config#use_tabs = 'false'

" print semicolons
" Prettier default: true
let g:prettier#config#semi = 'true'

" single quotes over double quotes
" Prettier default: false
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'

" avoid|always
" Prettier default: avoid
let g:prettier#config#arrow_parens = 'avoid'

" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'es5'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown
" Prettier default: babylon
let g:prettier#config#parser = 'flow'

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby compiler ruby
au BufWritePre *.js,*.jsx,*.css,*.json PrettierAsync
colorscheme iceberg

" Ctags path (brew install ctags)
let Tlist_Ctags_Cmd = '/usr/bin/ctags'

noremap <Leader>rt :!ctags --languages=ruby -R .<CR><CR>

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#sources#omni#force_omni_input_patterns')
    let g:neocomplete#sources#omni#force_omni_input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^.[:digit:] *\t]\%(\.\|->\)'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --max-count=1 --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Rga
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* RgCword
  \ call fzf#vim#grep(
  \   'rg --column --max-count=1 --line-number --no-heading --color=always '.expand("<cword>").'', 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
" Grep word under cursor:
command! -bang -nargs=* RgaCword
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.expand("<cword>").'', 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
if has('macunix')

  nnoremap <silent> ® :RgCword<CR>
  vnoremap <silent> ® :RgCword<CR>

  nnoremap <silent> ‰ :RgaCword<CR>
  vnoremap <silent> ‰ :RgaCword<CR>
elseif has('unix')

  nnoremap <silent> <M-r> :RgCword<CR>
  vnoremap <silent> <M-r> :RgCword<CR>

  nnoremap <silent> <M-r> :RgCword<CR>
  vnoremap <silent> <M-r> :RgCword<CR>
endif

