
" File              : git-auto-commit.vim
" Author            : daniel
" Date              : 2022-10-10
" vim: ts=8 sw=4 sts=4 et foldenable foldmethod=marker foldcolumn=1


scriptencoding utf-8

if exists('g:git_auto_commit_4210') | finish | endif " prevent loading file twice
let s:save_cpo = &cpo
set cpo&vim

let git_auto_commit_disable = get(g:, 'git_auto_commit_disable', 0)
let git_auto_commit_file_types = get(g:, 'git_auto_commit_file_types', ['*.md', '*.vim'])

if !git_auto_commit_disable
    " auto git commit at saving file(:w)
    augroup GitCommitGrp
      autocmd!
      execute('autocmd BufWritePost '.join(git_auto_commit_file_types, ',').' call git_auto#commit()')
    augroup end
endif

let &cpo = s:save_cpo
unlet s:save_cpo
let g:git_auto_commit_4210= 1
