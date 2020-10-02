# oh-my-zsh Theme
# Default bira theme with node version info.
# Installation: place this file in .oh-my-zsh/custom/themes/bira.zsh-theme
function node_prompt_version() {
    if which node &> /dev/null; then
        echo "%{$fg_bold[yellow]%}node(%{$fg[red]%}$(node -v)%{$fg[yellow]%}) %{$reset_color%}"
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}<"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}>"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info) $(node_prompt_version)%{$reset_color%}'
