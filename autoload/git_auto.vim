
" File              : git_auto.vim
" Author            : daniel
" Date              : 2022-10-10
" vim: ts=8 sw=4 sts=4 et foldenable foldmethod=marker foldcolumn=1


scriptencoding utf-8

let s:git_auto_commit_message = get(g:, 'git_auto_commit_message', 'vim-AutoComit')
let s:git_auto_commit_modify_lines_threshold = get(g:, 'git_auto_commit_modify_lines_threshold', 10)

" some command will affects files, need to fake run when testing
function! s:fakerun()
    return get(g:, 'git_auto_commit_fake_run', 0)
endfunction

function! git_auto#git_add(file) abort
    if s:fakerun() | return 1 | endif
    call system('git add ' . a:file)
    return v:shell_error == 0
endfunction

function! git_auto#git_commit(msg) abort
    if s:fakerun() | return 1 | endif
    call system('git commit -m ' . shellescape(a:msg, 1))
    return v:shell_error == 0
endfunction

function! git_auto#git_track_file(file) abort
    " --error-unmatch  return 1 if file is not in the git repo
    call system('git ls-files --error-unmatch -- '. a:file .' > /dev/null 2>&1')
    return v:shell_error == 0
endfunction

function! git_auto#git_diff_added_lines_count(file) abort
    let diffnumstat = system('git diff --numstat '. a:file . ' 2>/dev/null')
    "       <added_lines> <deleted_lines> <file>
    " ex:   2   1   xxxx/xxxx.txt
    let cols = split(diffnumstat, '\s\+')
    if len(cols) < 2
        return 0
    endif
    return str2nr(cols[0])
endfunction

" git commit file on saving(:w)
function git_auto#need_commit(file)
    if !git_auto#git_track_file(a:file)
        return 0
    endif
    let added_lines = git_auto#git_diff_added_lines_count(a:file)
    " dont commit too frequently, check that added_lines reachs 10s
    return added_lines >= s:git_auto_commit_modify_lines_threshold
endfunction

function! git_auto#commit(...)
    if a:0 > 0
        let filename = a:1
    else
        let filename = expand('%:t')
    endif
    if ! git_auto#need_commit(filename)
      return 0
    endif
    let s:message = s:git_auto_commit_message .' '. filename
    let succ = git_auto#git_add(filename) &&
        \ git_auto#git_commit(s:message)
    if succ
        silent echom 'success:'.s:message
    else
        silent echom 'failed'.s:message
    endif
    return succ
endfunction
