local user_host='%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}%{$fg[red]%}@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local git_branch='$(git_prompt_info)'
local venv_python='($CONDA_DEFAULT_ENV)%{$reset_color%}'

PS1="${user_host} ${current_dir} ${venv_python} ${git_branch}
$ "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]$fg[green]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"