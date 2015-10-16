set nocompatible              " be iMproved, required
filetype off                  " required
syntax enable
set background=dark

set hlsearch
set sw=4 
set ts=4
set et
set mouse=a
set clipboard=unnamedplus
"set list
set encoding=utf-8

if has("mouse_sgr")
    set ttymouse=sgr
end

nnoremap <F9> :set nu!<CR>

source ~/.vim/vim_plugins
 
"solarized
let g:solarized_termcolors = 256

"options: low, normal, high
let g:solarized_contrast = "normal" 
let g:solarized_visibility = "high"
let g:solarized_termtrans = 1
colorscheme solarized

"airline option
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
set laststatus=2

"clang options
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_global_ycm_extra_conf = '/home/jpedrick/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

nnoremap <F2> :YcmCompleter GoTo<CR>
nnoremap <C-F2> :YcmCompleter GoToImplementation<CR>
nnoremap <F3> :YcmCompleter GetType<CR>
nnoremap <C-F3> :YcmCompleter GetParent<CR>
command FixIt YcmCompleter FixIt
nnoremap <C-F7> :FixIt<CR>

"navigating source:
nnoremap <m-Left> <C-O>
nnoremap <m-Right> <C-I>

"swapit
nnoremap <F4> :call Swapit()<CR>
nnoremap <F6> :s/\w*\%#\w*/<C-R>"(\0)/<CR>
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch' }

"cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
