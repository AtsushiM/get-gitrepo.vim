"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/get-gitrepo.vim
"VERSION:  0.9
"LICENSE:  MIT

let g:get_gitrepo_PluginDir = expand('<sfile>:p:h:h').'/'
let g:get_gitrepo_TemplateDir = g:get_gitrepo_PluginDir.'template/'
let g:get_gitrepo_TemplateBeforePath = ''

if !exists("g:get_gitrepo_DefaultConfigDir")
    let g:get_gitrepo_DefaultConfigDir = $HOME.'/.projectroot/'
endif
if !exists("g:get_gitrepo_DefaultConfigFileTemplate")
    let g:get_gitrepo_DefaultConfigFileTemplate = '~ProjectRoot-Template~'
endif

if !exists("g:get_gitrepo_TemplateWindowSize")
    let g:get_gitrepo_TemplateWindowSize = 'topleft 15sp'
endif

" config
let s:get_gitrepo_DefaulTemplate = g:get_gitrepo_DefaultConfigDir.g:get_gitrepo_DefaultConfigFileTemplate

if !isdirectory(g:get_gitrepo_DefaultConfigDir)
    call mkdir(g:get_gitrepo_DefaultConfigDir)
endif
if !filereadable(s:get_gitrepo_DefaulTemplate)
    call system('cp '.g:get_gitrepo_TemplateDir.g:get_gitrepo_DefaultConfigFileTemplate.' '.s:get_gitrepo_DefaulTemplate)
endif

command! GitList call ggr#Template()
command! -nargs=1 GetGitRepo call ggr#GetGitRepo(<f-args>)

exec 'au BufRead '.g:get_gitrepo_DefaultConfigFileTemplate.' call ggr#SetBufMapProjectTemplateFile()'
exec 'au BufWinLeave '.g:get_gitrepo_DefaultConfigFileTemplate.' call ggr#TemplateClose()'
exec 'au BufReadPre '.g:get_gitrepo_DefaultConfigFileTemplate.' let g:get_gitrepo_TemplateBeforePath = getcwd()'
