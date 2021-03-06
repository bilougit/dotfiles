call plug#begin('~/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'evidens/vim-twig'
" Make vim pretty with nova-vim
Plug 'sheerun/vim-polyglot'
Plug 'trevordmiller/nova-vim'
Plug 'pearofducks/ansible-vim'
Plug 'preservim/nerdtree'
" Slows down vim 😥
" Plug 'Xuyuanp/nerdtree-git-plugin'
" """"""""""""""""""""""""""""""""""
" """"""""""""""""""""""""""""""""""
" Erreur détectée en traitant function miniyank#on_yank[14]..miniyank#write :
" Retry to install this later
" Plug 'bfredl/nvim-miniyank'
Plug 'moll/vim-bbye'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'amiorin/vim-project'
Plug 'mhinz/vim-startify' " php project management but quite complicated
"Plug 'StanAngeloff/php.vim' " php syntax but complicated
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'elythyr/phpactor-mappings'

" Syntax highlighter
Plug 'vim-syntastic/syntastic'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Manage tags files (for ctags) ?
Plug 'ludovicchabant/vim-gutentags'

" Basic autocomplete
Plug 'shawncplus/phpcomplete.vim'

Plug 'wincent/ferret'
Plug 'neomake/neomake'
Plug 'adoy/vim-php-refactoring-toolbox' " shortcuts don't work yet
Plug 'mhinz/vim-signify'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'vim-vdebug/vdebug' " Project path needs to be specified https://bit.ly/35ll1N1
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons' " Should be loaded last

" Best autocomplete tool ever
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Nice plugins
""""""""""""""

Plug 'editorconfig/editorconfig-vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Scratch
Plug 'bilougit/basicscratch'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""

" General setup

if !has('gui_running')
  set t_Co=256
endif

" My own config
" """""""""""""
syntax on
" show existing tab with 4 spaces width
set tabstop=4

" soft tab width
set softtabstop=4
set shiftwidth=4

" 4 spaces tab
set expandtab

set autoindent

" numbered lines
set relativenumber

" add directories of ./ to path
set path=.
" set path+=**

" Highlight current line
set cursorline

set colorcolumn=80,120

" backup vim
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Highlight search
set hls

" Switch leader from \ to space
let mapleader = ","

" reload files when they change on disk (e.g., git checkout)
set autoread

" Replace the word under the cursor
" Open a new command to complete with the word to substitute with
" Example:
" The cursor is on the word "foo".
" Hitting <leader>s will open ":%s/foo/"
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

""""""""""""""""""""""""""""""""""""""""""

" Plugins configurations
" """"""""""""""""""""""
"
" NERDTree
" """"""""
" How can I map a specific key or shortcut to open NERDTree?
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Lightline.vim
" """""""""""""
set laststatus=2

" vim-commentary
" """"""""""""""
" gcc to comment a line
" gcj to comment the current and the line below
" gc4j to comment the current and four lines below

" tpope/vim-abolish
" """"""""""""""
" feat1
" :%Subvert/facilit{y,ies}/building{,s}/g  does the same as the three lines below
" :%s/facilities/buildings/g
" :%s/Facilities/Buildings/g
" :%s/FACILITIES/BUILDINGS/g
"
" feat2
" :Abolish that makes it easier than the native :iabbrev
"
" feat3
" Want to turn fooBar into foo_bar? Press crs (coerce to snake_case).
" MixedCase (crm),
" camelCase (crc),
" snake_case (crs),
" UPPER_CASE (cru),
" dash-case (cr-),
" dot.case (cr.),
" space case (cr<space>),
" and Title Case (crt) are all just 3 keystrokes away.
" """"""""""""""

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" phpactor/ncm2-phpactor
" autocmd BufEnter * call ncm2#enable_for_buffer()
" set completeopt=noinsert,menuone,noselect

" ripgrep
nnoremap <leader>a :Rg<space>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<cr>

" fzf
  " \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
autocmd VimEnter * command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!tags*" --glob "!*.xml" --glob "!*.cache" --glob "!tests/*" --glob "!infection/*" --color "always" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" let g:fzf_tags_command = 'ctags -R' " this is the default value
" let g:fzf_tags_command = '.git/hooks/ctags'

" neomake
" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)

" vim-php-refactoring-toolbox
" nmap <C-M-o> :call PhpDetectUnusedUseStatements()<CR> " Does not work

" vim-signify
set updatetime=100

" tagbar
nmap <F8> :TagbarToggle<CR>

" CTAGS
"
" :ts or :tselect shows the list
" :tn or :tnext goes to the next tag in that list
" :tp or :tprev goes to the previous tag in that list
" :tf or :tfirst goes to the first tag of the list
" :tl or :tlast goes to the last tag of the list
"
" generated file can be under .git folder too
" set tags+=.git/tags
" Generates php ctags on save
" au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &
set tags=tags

" ctrlp.vim with ctags
nnoremap <leader>oo :CtrlPTag<CR>

" ctrlp.vim
" """""""""
" This is copied from a blog and I'm not sure all
" of the setups below are working.
"
" Setup some default ignores
  "\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v(\.(exe|so|dll|class|png|jpg|jpeg)|c?tags(\.(temp|lock))?)$',
\}

let g:ctrlp_user_command = 'find %s -type f'

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
" If a file is already open, open it again in a new pane instead of switching to the existing pane
let g:ctrlp_switch_buffer = 'et'

" vim-unimpaired
nmap ( [
nmap ) ]
omap ( [
omap ) ]
xmap ( [
xmap ) ]

" vim-devicons 
set encoding=UTF-8

" phpunit.vim
let g:php_bin = 'docker-compose exec -T -u root php php'
let g:phpunit_bin = 'vendor/bin/phpunit'
let g:phpunit_testroot = 'tests/unit'

" Personal
" """"""""

" Welcoming message
echo "ysiw'           => surround the current word with simple quote"
echo "da[             => same as di[ except it deletes bracket too"
echo "dt<space>       => same as df<space> except it won't delete the space"
echo ":earlier 2m     => gets 2 minutes back to the file version"
echo "           ================="
echo "             FINDING FILES"
echo "           ================="
echo "\" Searches down into subfolders"
echo "\" Provides tab-completion for all file-related tasks"
echo ":set path+=**"
echo "\" Displays all matching files when we tab complete"
echo ":set wildmenu"
echo "\" Autocompletes any open buffer"
echo ":b <some characters>"
echo "\" ctags moment"
echo "ctags -R . \" this will generate tags"
echo "<C-$> will go to the definition of the word you're on"
echo "<C-t> will go back to the previous tag you were on"
echo "\"vip\" will select the paragraph the cursor is in"

" Editing and sourcing $MYVIMRC fast
nnoremap <leader>ev :vsplit $MYVIMRC<cr>G
nnoremap <leader>sv :source $MYVIMRC<cr>

inoremap jk <esc>

" Some php abbreviations
iabbrev cls class
iabbrev impl implements
iabbrev rfoundation Symfony\Component\HttpFoundation\

" {{{{{{{{{{{{{{{{{{{
" Integrate fd command
function! ExtractStringFromLine()
endfunction

function! FastFindFile(filename)
    let fd_result = system('! fd -i ' . a:filename . ' src')
    let size = split(fd_result, '\v\n')

    " Open a new split and set it up.
    split __fd_result__
    normal! ggdG
    setlocal buftype=nofile
    setlocal nowrap
    setlocal norelativenumber
    setlocal number
    nnoremap <buffer> q :q<cr>
    nnoremap <buffer> <silent> <cr> :execute 'tabnew '.getline('.')<cr>

    " Insert the bytecode.
    call append(0, size)

    setlocal readonly
    " Cannot work ever since you do many researches
    " setlocal nomodifiable
    normal! gg
    resize 10
endfunction

nnoremap <leader>fd :call FastFindFile(expand('<cword>'))<cr>
" }}}}}}}}}}}}}}}}}}}

" {{{{{{{{{{{{{{{{{{{
" Update selected composer package
function! UpdateComposer(rawPackageName)
    let packageName = substitute(a:rawPackageName, '"', '', 'g')
    let packageName = split(trim(packageName), ':')[0]

    execute '! docker-compose exec php composer u ' . packageName . ' -vvv'
    " let bytecode = system('docker-compose exec php composer u ' . packageName . ' -vvv')
endfunction

nnoremap <leader>com :call UpdateComposer(getline('.'))<cr>
" }}}}}}}}}}}}}}}}}}}

" {{{{{{{{{{{{{{{{{{{
" Update visual selected composer packages
function! s:ExtractComposerLine(composerLine)
    let packageName = substitute(a:composerLine, '"', '', 'g')
    let packageName = split(trim(packageName), ':')[0]

    return packageName
endfunction

function! VUpdateComposer(startNum, endNum)
    let start = a:startNum[1]
    let end = a:endNum[1]
    let packages = []

    while start < end
        let truc = s:ExtractComposerLine(getline(start))
        call add(packages, truc)

        let start += 1
    endwhile

    echo 'Updating... ' . join(packages, ' ')
    call UpdateComposer(join(packages, ' '))
endfunction

vnoremap <leader>vcom :<c-u>call VUpdateComposer(getpos("'<"), getpos("'>"))<cr>
" }}}}}}}}}}}}}}}}}}}

" {{{{{{{{{{{{{{{{{{{
" Go to php method definition in the same file
" TODO not finished yet
nnoremap <leader>d :normal /function <cword>(<cr>
" }}}}}}}}}}}}}}}}}}}

" {{{{{{{{{{{{{{{{{{{
" Rst plugin in the making
" TODO For now, it adds *** between the title
function! RstTitleTransform(titleText)
    let textLength = strlen(a:titleText)
    let titleMeta = repeat('*', textLength)

    exe "normal! O" . titleMeta . "\<Esc>"
    exe "normal! jo" . titleMeta . "\<Esc>k"
endfunction

nnoremap <leader>rt :<c-u>call RstTitleTransform(getline('.'))<cr>
" }}}}}}}}}}}}}}}}}}}

" {{{{{{{{{{{{{{{{{{{
" Bug1: when the cursor is between two methods
function! DisplayFunctionName(lineNumber)
    let firstLine = 1
    let currentNumber = a:lineNumber

    while currentNumber > firstLine
        let catchedLine = getline(currentNumber)
        let currentNumber = currentNumber - 1


        if catchedLine =~ '^ \+\(public\|private\|protected\) function '
            let functionName = substitute(catchedLine, '^ \+\(public\|private\|protected\) function ', '', 'g')
            echo functionName

            break
        endif
    endwhile
endfunction
" }}}}}}}}}}}}}}}}}}}

" {{{{{{{{{{{{{{{{{{{
nnoremap <leader>ab :tabnext<cr>
" }}}}}}}}}}}}}}}}}}}

" {{{{{{{{{{{{{{{{{{{
" TODO not finished yet
function! ReverseArgsOrder()
    let parenthesisContent = getline('.')
endfunction

" nnoremap <leader>rev :<c-u>call ReverseArgsOrder()<cr>
nnoremap <leader>rev :<c-u>call ReverseArgsOrder()<cr>
" }}}}}}}}}}}}}}}}}}}

" {{{{{{{{{{{{{{{{{{{
" call Scratch()
nnoremap <leader>scr :<c-u>call Scratch()<cr>
" }}}}}}}}}}}}}}}}}}}
