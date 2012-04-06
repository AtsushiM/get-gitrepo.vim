"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/get-gitrepo.vim
"VERSION:  0.9
"LICENSE:  MIT

let s:get_gitrepo_TemplateNo = 0
let s:get_gitrepo_TemplateOpen = 0

if !exists("g:get_gitrepo_delete_files")
    let g:get_gitrepo_delete_files = ['.git', '.gitignore']
endif

function ggr#getDirName(repo)
    return matchlist(a:repo, '\v(.*)/(.*)')[2]
endfunction

function! ggr#GetGitRepo(repo)
    echo 'Start GetGit:'
    call system('git clone git://github.com/'.a:repo.'.git')
    let dir = ggr#getDirName(a:repo)
    for e in g:get_gitrepo_delete_files
        call system('rm -r '.dir.'/'.e)
    endfor
    echo 'GetGit Done!'
endfunction

function! ggr#TemplateOpen()
    exec g:get_gitrepo_TemplateWindowSize.' '.g:get_gitrepo_DefaultConfigDir.g:get_gitrepo_DefaultConfigFileTemplate
    let s:get_gitrepo_TemplateOpen = 1
    let s:get_gitrepo_TemplateNo = bufnr('%')
endfunction

function! ggr#TemplateClose()
    let s:get_gitrepo_TemplateOpen = 0
    exec 'bw '.s:get_gitrepo_TemplateNo
    winc p
endfunction

function! ggr#Template()
    if s:get_gitrepo_TemplateOpen == 0
        call ggr#TemplateOpen()
    else
        call ggr#TemplateClose()
    endif
endfunction

function! ggr#Init()
    if g:get_gitrepo_TemplateBeforePath != ''
        echo "GetGit:"

        exec 'cd '.g:get_gitrepo_TemplateBeforePath

        let repo = getline('.')
        call ggr#GetGitRepo(repo)

        call ggr#TemplateClose()

        let dir = ggr#getDirName(repo)

        exec 'e '.g:get_gitrepo_TemplateBeforePath.'/'.dir.'/..'
    else
        echo 'No before path.'
    endif
endfunction

function! ggr#SetBufMapProjectTemplateFile()
    set cursorline
    nnoremap <buffer><silent> e :call ggr#FPInit()<CR>
    nnoremap <buffer><silent> <CR> :call ggr#Init()<CR>
    nnoremap <buffer><silent> q :call ggr#TemplateClose()<CR>
endfunction
