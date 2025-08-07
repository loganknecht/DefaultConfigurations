local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local user_symbol='%(!.#.$)'
local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"
local conda_prompt='$(conda_prompt_info)'

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'
if [[ "${plugins[@]}" =~ 'kube-ps1' ]]; then
    local kube_prompt='$(kube_ps1)'
else
    local kube_prompt=''
fi

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${conda_prompt}${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}${kube_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

# --------------------
# OLD
# --------------------
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
# ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[yellow]%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"
# --------------------
# CUSTOM
# --------------------
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
PROMPT='${ret_status} %{$fg[cyan]%}%d%{$reset_color%} $(git_prompt_info) $(node_prompt_version)%{$reset_color%}'
# --------------------

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
