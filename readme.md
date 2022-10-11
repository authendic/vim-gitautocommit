# vim git auto commit

When a file in git repo is modified pretty much, It is helpful to commit it to git autoly.
This plugin is launched for this purpose, just plug and use, zero config.

## install

1. vim-plug

    ```vim
    Plug 'authendic/vim-template', {'branch': 'release'}
    ```

## config

1. Zero Config, plug and use

    By default, file type like `*.md` and  `*.vim`  will be autocommited , since the file must be in git repo

1. disabling autocommit

    ```vim
    let g:git_auto_commit_disable = 1
    ```

1. auto commit file types

    ```vim
    let g:git_auto_commit_file_types = ['*.md', '*.vim']
    ```

1. auto commit message

    ```vim
    let g:git_auto_commit_message = 'auto commit'
    ```

1. threshod for control commit frequency

    ```vim
    " 5 row added, trigger a commit
    let g:git_auto_commit_modify_lines_threshold = 5
    ```

## have fun

