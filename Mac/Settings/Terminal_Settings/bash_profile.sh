# Path to your oh-my-zsh installation.
export ZSH=/Users/lknecht/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="agnoster"
# ZSH_THEME="michelebologna"
# ZSH_THEME="dstufft"
ZSH_THEME="bira"
# ZSH_THEME="Solarized" - this isn't installed


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/lknecht/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


################################################################################
# Personal Configurations
################################################################################
########################################
# I have no idea why this is here
########################################
# disable special creation/extraction of ._* files by tar, etc. on Mac OS X
COPYFILE_DISABLE=1;
export COPYFILE_DISABLE

########################################
# Shell Commands
########################################
# If you are running Splunk in a medium to large environment, you are probably 
# sharing Splunk with other groups. In many places, this results in one group 
# running Splunk as a service for any number of internal customers. The 
# challenge then becomes sharing the maintenance and run costs of the 
# infrastructure. As a Splunk administrator, I would have to run several 
# long-running searches to try and figure out the costs. This App should put all
# of that to rest.
SPLUNK_HOME="/Applications/Splunk" 
SPLUNK_CORE_LIB="$SPLUNK_HOME/lib/python2.7/site-packages/splunk"
export SPLUNK_HOME 
export SPLUNK_CORE_LIB
export PATH=$PATH:~/bin 
 
########################################
# Shell Commands
########################################
# Not used in zsh
# alias ll='ls -lG' 
# alias la='ls -a' 
cls(){
clear
}

########################################
# Git Commands
########################################
# Copied from here: https://coderwall.com/p/x3jmig/remove-all-your-local-git-branches-but-keep-master
alias gbr="git branch | grep -v 'master' | xargs git branch -D"
alias gba="git branch -a" 
alias gl="git log --pretty=oneline -10"
alias gn="echo 'NUKING GIT CONFIGURATIONS BACK TO HEAD' && git reset --hard HEAD && git clean -dfx && git remote prune origin && git pull" # Stands for git-nuke

########################################
# Python Commands
########################################
killallpython() {
ps -ax | grep python | awk '{print $1}' | xargs kill -9
}

alias venv_create="virtualenv -p pthon3 venv && source venv/bin/activate"
alias venv_start="source venv/bin/activate"

########################################
# Docker Commands
########################################
# https://gist.github.com/ngpestelos/4fc2e31e19f86b9cf10b
alias drc="docker ps -q -a | xargs docker rm -f"
alias drn="docker images | grep none | awk '{print $3}' | xargs docker rmi -f"

dc() { 
docker-compose $@
}

dm() {
docker-machine $@
}

dm-switch() { 
eval $(dm env $@) 
}

########################################
# Sublime Text Commands
########################################
# Sublime Text must be symbolically linked to 'subl' in ~/bin 
st() {
subl $@ 
}

ste() {
subl $@ 
exit
}


########################################
# SSH
########################################
kill-all-ssh() {
ps -a | grep ssh | awk '{ print $1 }' | xargs kill -9
}

lenny() {
    echo " (    ͡°  ͜ʖ   ͡°)" | pbcopy
}

shrug() {
    echo "¯\_(ツ)_/¯" | pbcopy
}