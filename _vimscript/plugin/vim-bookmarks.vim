" Settings for vim-bookmarks
" ==========================

let g:bookmark_save_per_working_dir = 0
let g:bookmark_auto_save = 1
let g:bookmark_manager_per_buffer = 0
let g:bookmark_auto_save_file = $VARPATH.'/bookmarks'
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_disable_ctrlp = 1

" Functions to toggle mapping and unmapping of keys when NERDTree is open
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
    nmap ma :BookmarkShowAll<CR>
    nmap mc :BookmarkClear<CR>
    nmap mx :BookmarkClearAll<CR>
    nmap mkk :BookmarkMoveUp
    nmap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap ma
    unmap mc
    unmap mx
    unmap mkk
    unmap mjj
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()

" Finds the Git super-project directory based on the file passed as an argument.
" Not sure if I'll keep this for now
" function! g:BMBufferFileLocation(file)
"     let filename = 'vim-bookmarks'
"     let location = ''
"     if isdirectory(fnamemodify(a:file, ":p:h").'/.git')
"         " Current work dir is git's work tree
"         let location = fnamemodify(a:file, ":p:h").'/.git'
"     else
"         " Look upwards (at parents) for a directory named '.git'
"         let location = finddir('.git', fnamemodify(a:file, ":p:h").'/.;')
"     endif
"     if len(location) > 0
"         return simplify(location.'/.'.filename)
"     else
"         return simplify(fnamemodify(a:file, ":p:h").'/.'.filename)
"     endif
" endfunction
