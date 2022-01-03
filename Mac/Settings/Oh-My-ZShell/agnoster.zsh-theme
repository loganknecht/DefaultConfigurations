# ------------------------------------------------------------------------------
# Custom Settings
# ------------------------------------------------------------------------------
#AWS Profile:
# - display current AWS_PROFILE name
# - displays yellow on red if profile name contains 'production' or
#   ends in '-prod'
# - displays black on green otherwise
prompt_aws() {
    [[ -z "$AWS_PROFILE" || "$SHOW_AWS_PROMPT" = false ]] && return
    case "$AWS_PROFILE" in
    *-prod | *production*) prompt_segment red yellow "AWS: $AWS_PROFILE" ;;
    *) prompt_segment green black "AWS: $AWS_PROFILE" ;;
    esac
}

prompt_bzr() {
    (($ + commands[bzr])) || return

    # Test if bzr repository in directory hierarchy
    local dir="$PWD"
    while [[ ! -d "$dir/.bzr" ]]; do
        [[ "$dir" = "/" ]] && return
        dir="${dir:h}"
    done

    local bzr_status status_mod status_all revision
    if bzr_status=$(bzr status 2>&1); then
        status_mod=$(echo -n "$bzr_status" | head -n1 | grep "modified" | wc -m)
        status_all=$(echo -n "$bzr_status" | head -n1 | wc -m)
        revision=$(bzr log -r-1 --log-format line | cut -d: -f1)
        if [[ $status_mod -gt 0 ]]; then
            prompt_segment yellow black "bzr@$revision ✚"
        else
            if [[ $status_all -gt 0 ]]; then
                prompt_segment yellow black "bzr@$revision"
            else
                prompt_segment green black "bzr@$revision"
            fi
        fi
    fi
}

prompt_hg() {
    (($ + commands[hg])) || return
    local rev st branch
    if $(hg id >/dev/null 2>&1); then
        if $(hg prompt >/dev/null 2>&1); then
            if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
                # if files are not added
                prompt_segment red white
                st='±'
            elif [[ -n $(hg prompt "{status|modified}") ]]; then
                # if any modification
                prompt_segment yellow black
                st='±'
            else
                # if working copy is clean
                prompt_segment green $CURRENT_FG
            fi
            echo -n $(hg prompt "☿ {rev}@{branch}") $st
        else
            st=""
            rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
            branch=$(hg id -b 2>/dev/null)
            if $(hg st | grep -q "^\?"); then
                prompt_segment red black
                st='±'
            elif $(hg st | grep -q "^[MA]"); then
                prompt_segment yellow black
                st='±'
            else
                prompt_segment green $CURRENT_FG
            fi
            echo -n "☿ $rev@$branch" $st
        fi
    fi
}

# From: https://github.com/caiogondim/bullet-train.zsh/blob/master/bullet-train.zsh-theme
# NVM: output current node version if NVM present
if [ ! -n "${BULLETTRAIN_NVM_BG+1}" ]; then
    BULLETTRAIN_NVM_BG=green
fi
if [ ! -n "${BULLETTRAIN_NVM_FG+1}" ]; then
    BULLETTRAIN_NVM_FG=magenta
fi
if [ ! -n "${BULLETTRAIN_NVM_PREFIX+1}" ]; then
    BULLETTRAIN_NVM_PREFIX="⬡ "
fi
prompt_nvm() {
    local nvm_prompt
    if type nvm >/dev/null 2>&1; then
        nvm_prompt=$(nvm current 2>/dev/null)
        [[ "${nvm_prompt}x" == "x" || "${nvm_prompt}" == "system" ]] && return
    elif type node >/dev/null 2>&1; then
        nvm_prompt="$(node --version)"
    else
        return
    fi

    nvm_prompt=${nvm_prompt}

    prompt_segment $BULLETTRAIN_NVM_BG $BULLETTRAIN_NVM_FG $BULLETTRAIN_NVM_PREFIX$nvm_prompt
}
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Default Settings
# ------------------------------------------------------------------------------
# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segments of the prompt, default order declaration

typeset -aHg AGNOSTER_PROMPT_SEGMENTS=(
    prompt_status
    prompt_virtualenv
    prompt_aws # Custom
    prompt_context
    prompt_dir
    prompt_git
    prompt_bzr # Custom
    prompt_hg  # Custom
    prompt_nvm # Custom
    prompt_end
)

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
    # PRIMARY_FG=black
    PRIMARY_FG=white
fi

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
    else
        print -n "%{$bg%}%{$fg%}"
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        print -n "%{%k%}"
    fi
    print -n "%{%f%}"
    CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
    local user=$(whoami)

    if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
        # Old
        # prompt_segment $PRIMARY_FG default " %(!.%{%F{yellow}%}.)$user@%m "
        # Custom
        prompt_segment black default "%(!.%{%F{yellow}%}.)%n"
    fi
}

# Git: branch/detached head, dirty status
prompt_git() {
    local color ref
    is_dirty() {
        test -n "$(git status --porcelain --ignore-submodules)"
    }
    ref="$vcs_info_msg_0_"
    if [[ -n "$ref" ]]; then
        if is_dirty; then
            GIT_FG_COLOR=black # Custom
            color=yellow
            ref="${ref} $PLUSMINUS"
        else
            GIT_FG_COLOR=black # Custom
            color=green
            ref="${ref} "
        fi
        if [[ "${ref/.../}" == "$ref" ]]; then
            ref="$BRANCH $ref"
        else
            ref="$DETACHED ${ref/.../}"
        fi
        # Old
        # prompt_segment $color $PRIMARY_FG
        # Custom
        prompt_segment $color $GIT_FG_COLOR
        print -n " $ref"
    fi
}

# Dir: current working directory
prompt_dir() {
    prompt_segment blue $PRIMARY_FG ' %~ '
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$CROSS"
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$LIGHTNING"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$GEAR"

    [[ -n "$symbols" ]] && prompt_segment $PRIMARY_FG default " $symbols "
}

# Display current virtual environment
prompt_virtualenv() {
    if [[ -n $VIRTUAL_ENV ]]; then
        color=cyan
        prompt_segment $color $PRIMARY_FG
        print -Pn " $(basename $VIRTUAL_ENV) "
    fi
}

## Main prompt
prompt_agnoster_main() {
    RETVAL=$?
    CURRENT_BG='NONE'
    for prompt_segment in "${AGNOSTER_PROMPT_SEGMENTS[@]}"; do
        [[ -n $prompt_segment ]] && $prompt_segment
    done
}

prompt_agnoster_precmd() {
    vcs_info
    PROMPT='%{%f%b%k%}$(prompt_agnoster_main) '
}

prompt_agnoster_setup() {
    autoload -Uz add-zsh-hook
    autoload -Uz vcs_info

    prompt_opts=(cr subst percent)

    add-zsh-hook precmd prompt_agnoster_precmd

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' check-for-changes false
    zstyle ':vcs_info:git*' formats '%b'
    zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_agnoster_setup "$@"
